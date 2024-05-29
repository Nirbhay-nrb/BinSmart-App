// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:convert';

import 'package:binsmart/constants.dart';
import 'package:binsmart/providers/classes/cleaner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cleaners with ChangeNotifier {
  List<Cleaner> _cleaners = [
    Cleaner(
        userId: '665762e871703758647da0ca',
        name: 'c1',
        communityId: '65f82a819c8c2cceebe47723'),
    Cleaner(
        userId: 'userId', name: 'c2', communityId: '65f82a819c8c2cceebe47723'),
    Cleaner(
        userId: 'userId', name: 'c3', communityId: '65f82a819c8c2cceebe47723'),
    Cleaner(
        userId: 'userId', name: 'c4', communityId: '65f82a819c8c2cceebe47723'),
  ];

  List<Cleaner> get cleaners {
    return [..._cleaners];
  }

  Future<void> getCleanersOfCommunity(communityId) async {
    print(' inside get all cleaners for community : $communityId');
    String url = '$kApiURL/community/cleaners/$communityId';
    try {
      http.Response response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      print(data);
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
