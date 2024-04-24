import 'package:flutter/material.dart';

double screenHeight(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final height = switch (mediaQuery.orientation) {
    Orientation.portrait => mediaQuery.size.height,
    Orientation.landscape => mediaQuery.size.width
  };
  return height;
}

double screenWidth(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final width = switch (mediaQuery.orientation) {
    Orientation.portrait => mediaQuery.size.width,
    Orientation.landscape => mediaQuery.size.width
  };
  return width;
}

(double height, double width) screenSize(BuildContext context) {
  return (screenHeight(context), screenWidth(context));
}
