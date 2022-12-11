import 'package:flutter/material.dart';
import 'package:market_app/widgets/auth_dialog.dart';

class RouteManager {

  static const String loginPage = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (context) => AuthDialog());

      default:
        throw const FormatException("Exception");
    }
  }
}