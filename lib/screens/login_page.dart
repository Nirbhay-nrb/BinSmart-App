// ignore_for_file: prefer_const_constructors

import 'package:binsmart/constants.dart';
import 'package:binsmart/routes/route_names.dart';
import 'package:binsmart/widgets/button.dart';
import 'package:binsmart/widgets/input_field.dart';
import 'package:binsmart/widgets/title.dart';
import 'package:flutter/material.dart';

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
                    hinttext: widget.user == 'Manager'
                        ? 'Manager Email'
                        : (widget.user == 'Cleaner'
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
                      // if (widget.userRole == 'caretaker') {
                      //   if (email == 'john@gmail.com' && password == 'test123') {
                      //     Navigator.pushNamed(context, RouteNames.caretakerpage);
                      //   }
                      // } else {
                      //   if (email == 'shagun@gmail.com' && password == 'test123') {
                      //     Navigator.pushNamed(context, RouteNames.userpage);
                      //   }
                      // }
                      // sending the login request to the API
                      // try {
                      //   await Provider.of<Auth>(context, listen: false)
                      //       .loginUser(email, password, widget.userRole);
                      //   String id = Provider.of<Auth>(context, listen: false).id;
                      //   print(id);
                      //   if (id != '') {
                      //     // navigating to the next page
                      // widget.userRole == 'Caretaker'
                      //     ? Navigator.pushNamed(
                      //         context, RouteNames.caretakerpage)
                      //     : Navigator.pushNamed(context, RouteNames.userpage);
                      //   }
                      // } catch (e) {
                      //   print(e);
                      //   showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return ErrorBox(
                      //         errorText: e.toString(),
                      //         onpressed: () {
                      //           Navigator.pop(context);
                      //         },
                      //       );
                      //     },
                      //   );
                      // }
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
