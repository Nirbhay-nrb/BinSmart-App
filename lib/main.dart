// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:binsmart/providers/routes/cleaners.dart';
import 'package:binsmart/providers/routes/complaints.dart';
import 'package:binsmart/providers/routes/dustbins.dart';
import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'routes/route_names.dart';
import 'package:provider/provider.dart';
import 'providers/routes/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Complaints()),
        ChangeNotifierProvider.value(value: Dustbins()),
        ChangeNotifierProvider.value(value: Cleaners()),
      ],
      child: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: RouteNames.homepage,
    );
  }
}
