// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    required this.hinttext,
    required this.onChanged,
    required this.obscure,
    required this.controller,
    required this.keyboardType,
  });
  final bool obscure;
  final String hinttext;
  final Function onChanged;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      controller: controller,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'PoppinsB',
      ),
      onChanged: (value) {
        onChanged(value);
      },
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(
          decorationColor: Colors.black54,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.yellow,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
