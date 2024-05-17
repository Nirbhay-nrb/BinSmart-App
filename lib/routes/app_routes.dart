import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../screens/login_page.dart';
import '../screens/register_page.dart';
import 'route_names.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homepage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RouteNames.login:
        var userRole = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => LoginPage(
                  user: userRole,
                ));
      case RouteNames.register:
        var userRole = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => RegisterPage(
                  user: userRole,
                ));
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
