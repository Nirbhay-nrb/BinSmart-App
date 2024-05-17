// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:binsmart/constants.dart';
import 'package:binsmart/routes/route_names.dart';
import 'package:binsmart/widgets/button.dart';
import 'package:binsmart/widgets/title.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TitleToDisplay(
              displayText: 'Bin Smart',
              size: 75,
            ),
            SizedBox(
              height: 20,
            ),
            Button(
              displayText: 'Manager',
              clr: kButtonColor,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.login,
                  arguments: kUserType.elementAt(0),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Button(
              displayText: 'Cleaner',
              clr: kButtonColor,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.login,
                  arguments: kUserType.elementAt(1),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Button(
              displayText: 'Public',
              clr: kButtonColor,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.login,
                  arguments: kUserType.elementAt(2),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
