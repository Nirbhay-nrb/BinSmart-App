// ignore_for_file: avoid_print, prefer_final_fields

import 'dart:convert';

import 'package:binsmart/constants.dart';
import 'package:binsmart/providers/classes/dustbin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dustbins with ChangeNotifier {
  List<Dustbin> _dustbins = [
    Dustbin(
      dustbinId: '65f8ceb7e143e988c98d6acb',
      communityId: '65f82a819c8c2cceebe47723',
      location: Location(
          building: 'csed',
          floor: '5th floor',
          room: '301',
          description: 'in front of the door'),
      lastCleanedDate: '13/05/2023',
      lastCleanedTime: '12:05:00AM',
      filledStatus: '50',
      cleanerId: '',
    ),
    Dustbin(
      dustbinId: '',
      communityId: '',
      location: Location(
          building: 'csed',
          floor: '4thfloor',
          room: '301',
          description: 'in front of the door'),
      lastCleanedDate: '13/05/2023',
      lastCleanedTime: '12:05:00AM',
      filledStatus: '75',
      cleanerId: '',
    ),
    Dustbin(
      dustbinId: '',
      communityId: '',
      location: Location(
          building: 'csed',
          floor: '5',
          room: '301',
          description: 'in front of the door'),
      lastCleanedDate: '13/05/2023',
      lastCleanedTime: '12:05:00AM',
      filledStatus: '100',
      cleanerId: '',
    )
  ];

  List<Dustbin> get dustbins {
    return [..._dustbins];
  }

  Future<void> getDustbinsOfCommunity(communityId, accessToken) async {
    String url = '$kApiURL/dustbin/community/$communityId';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': accessToken,
        },
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        print('Dustbins fetched successfully');
      } else {
        print('Failed to get dustbins');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> getDustbinsOfCleaner(cleanerId, accessToken) async {
    String url = '$kApiURL/dustbin/cleaner/$cleanerId';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': accessToken,
        },
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        print('Dustbins fetched successfully');
      } else {
        print('Failed to get dustbins');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
