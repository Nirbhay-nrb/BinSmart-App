// ignore_for_file: prefer_const_constructors

import 'package:binsmart/constants.dart';
import 'package:binsmart/widgets/button.dart';
import 'package:binsmart/widgets/input_field.dart';
import 'package:binsmart/widgets/title.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final String user;
  const RegisterPage({super.key, required this.user});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name = '';
  String email = '';
  String password = '';
  String phone = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: TitleToDisplay(
                    displayText: 'Register',
                    size: 60,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      InputField(
                        keyboardType: TextInputType.text,
                        hinttext: 'Name',
                        onChanged: (value) {
                          name = value;
                        },
                        obscure: false,
                        controller: _nameController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputField(
                        keyboardType: TextInputType.emailAddress,
                        hinttext: 'Email',
                        onChanged: (value) {
                          email = value;
                        },
                        obscure: false,
                        controller: _emailController,
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
                      SizedBox(
                        height: 20,
                      ),
                      InputField(
                        keyboardType: TextInputType.number,
                        hinttext: 'Phone number',
                        onChanged: (value) {
                          phone = value;
                        },
                        obscure: false,
                        controller: _phoneController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Button(
                          displayText: 'Register',
                          clr: kButtonColor,
                          onTap: () async {
                            print('$name : $email : $password : $phone');
                            // sending registration request to the API
                            // try {
                            //   await Provider.of<Auth>(context, listen: false)
                            //       .registerUser(
                            //           name, email, password, phone, date, role);
                            //   String id =
                            //       Provider.of<Auth>(context, listen: false).id;
                            //   print(id);
                            //   if (id != '') {
                            //     // navigating to the next page
                            //     role == 'Caretaker'
                            //         ? Navigator.pushNamed(
                            //             context, RouteNames.caretakerpage)
                            //         : Navigator.pushNamed(
                            //             context, RouteNames.userpage);
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
                            // clearing all the fields
                            _nameController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                            _phoneController.clear();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*
role (already passed)
name
email
password
phone number
*/