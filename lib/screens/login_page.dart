// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:binsmart/constants.dart';
import 'package:binsmart/providers/routes/auth.dart';
import 'package:binsmart/routes/route_names.dart';
import 'package:binsmart/widgets/button.dart';
import 'package:binsmart/widgets/error_box.dart';
import 'package:binsmart/widgets/input_field.dart';
import 'package:binsmart/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final String user;

  const LoginPage({super.key, required this.user});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: TitleToDisplay(
                displayText: 'Login',
                size: 60,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  InputField(
                    hinttext: widget.user == 'manager'
                        ? 'Manager Email'
                        : (widget.user == 'cleaner'
                            ? 'Cleaner Email'
                            : 'Public User Email'),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    obscure: false,
                    controller: _usernameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputField(
                    keyboardType: TextInputType.text,
                    hinttext: 'Password',
                    onChanged: (value) {
                      password = value;
                    },
                    obscure: true,
                    controller: _passwordController,
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Button(
                    displayText: 'Login',
                    clr: kButtonColor,
                    onTap: () async {
                      print('$email : $password');

                      // sending the login request to the API
                      try {
                        await Provider.of<Auth>(context, listen: false)
                            .loginUser(email, password);
                        String id =
                            Provider.of<Auth>(context, listen: false).userId;
                        if (id != '') {
                          // navigating to the next page
                          print('user ID on succesful login : $id');
                          if (widget.user == 'manager') {
                            Navigator.pushNamed(context, RouteNames.manager);
                          } else if (widget.user == 'cleaner') {
                            Navigator.pushNamed(context, RouteNames.cleaner);
                          } else if (widget.user == 'resident') {
                            Navigator.pushNamed(context, RouteNames.resident);
                          }
                        }
                      } catch (e) {
                        print(e);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorBox(
                              errorText: e.toString(),
                              onpressed: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      }

                      // clearing the fields
                      _usernameController.clear();
                      _passwordController.clear();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Text(
                      'New? Register here!',
                      style: TextStyle(
                        fontSize: 16,
                        color: kGrayishWhite,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.register,
                          arguments: widget.user);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
