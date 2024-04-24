sealed class Result<S, F> {
  const Result();
}

final class Success<S, F> extends Result<S, F> {
  final S _s;
  const Success(this._s);

  S get value => _s;
}

final class Failure<S, F> extends Result<S, F> {
  final F _f;
  const Failure(this._f);

  F get value => _f;
}
