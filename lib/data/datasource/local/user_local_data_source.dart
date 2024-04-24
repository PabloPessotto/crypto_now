import 'package:crypto_now/data/models/user_dto.dart';
import 'package:sqflite/sql.dart';

import 'local_database.dart';

abstract interface class UserLocalDataSource {
  Future<UserDto?> insertUser(UserDto user);
  Future<UserDto?> getUserByEmail(String email);
  Future<void> updateUserLogged(int userId);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final LocalDatabase _localDatabase;

  UserLocalDataSourceImpl(this._localDatabase);

  @override
  Future<UserDto?> getUserByEmail(String email) async {
    final db = await _localDatabase.database;
    List<Map<String, dynamic>> maps =
        await db.query('user', where: 'email = ?', whereArgs: [email]);
    if (maps.isNotEmpty) {
      return UserDto.fromJson(maps.first);
    }
    return null;
  }

  @override
  Future<UserDto?> insertUser(UserDto user) async {
    final db = await _localDatabase.database;
    final int id = await db.insert('user', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    final queryUser = await db.query('user', where: 'id = ?', whereArgs: [id]);
    if (queryUser.isEmpty) return null;

    return UserDto.fromJson(queryUser.first);
  }

  @override
  Future<void> updateUserLogged(int userId) async {
    final db = await _localDatabase.database;
    await db.update(
      'user',
      {
        "startSession":
            DateTime.now().add(const Duration(minutes: 10)).millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [userId],
    );
  }
}
