// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:binsmart/constants.dart';
import 'package:binsmart/providers/classes/cleaner.dart';
import 'package:binsmart/providers/classes/manager.dart';
import 'package:binsmart/providers/classes/public.dart';
import 'package:binsmart/providers/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String accessToken = '';
  String role = '';
  String userId = '';
  late User currentUser;
  late Resident currentResident;
  late Manager currentManager;
  late Cleaner currentCleaner;
  Future<void> loginUser(email, password) async {
    String url = '$kApiURL/auth/login';
    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        'email': email,
        'password': password,
      });
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        print('Login Successful');
        accessToken = data['accessToken'];
        role = data['user']['role'];
        userId = data['user']['id'];
        await getCurrentUser();
      } else {
        print('Login Failed');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> getCurrentUser() async {
    String url = '$kApiURL/auth/user/$userId';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': accessToken,
        },
      );
      final data = jsonDecode(response.body);
      print('User data = \n $data');
      if (response.statusCode == 200) {
        currentUser = User(
            role: role,
            phoneNo: data['user']['phoneNumber'],
            email: data['user']['email']);
        if (role == 'manager') {
          print('inside manager');
          currentManager = Manager(
            userId: userId,
            name: data['user']['name'],
            communityId: data['user']['communityId'],
          );
        } else if (role == 'cleaner') {
          print('inside cleaner');
          currentCleaner = Cleaner(
            userId: userId,
            name: data['user']['name'],
            communityId: data['user']['communityId'],
          );
        } else if (role == 'resident') {
          print('inside resident');
          currentResident = Resident(
            userId: userId,
            name: data['user']['name'],
          );
        } else {
          print('No such user exists');
        }
      } else {
        print('No such user exists');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> registerUser(
      role, name, phoneNumber, email, password, communityId) async {
    String url = '$kApiURL/auth/register';

    print(
        'data to be sent : $role : $name : $phoneNumber : $email : $password : $communityId');
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: {
          'role': role,
          'name': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'password': password,
          'communityId': communityId,
        },
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        print('Registration Successful');
        accessToken = data['accessToken'];
        role = data['user']['role'];
        userId = data['user']['id'];
        await getCurrentUser();
      } else {
        print('Registration Failed');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
