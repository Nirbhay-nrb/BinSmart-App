// ignore_for_file: avoid_print, prefer_final_fields

import 'dart:convert';

import 'package:binsmart/constants.dart';
import 'package:binsmart/providers/classes/complaint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Complaints with ChangeNotifier {
  List<Complaint> _complaints = [
    Complaint(
      title: 'comp 1',
      communityId: '65f82a819c8c2cceebe47723',
      status: 'pending',
      description: 'description 1',
      dateOfComplaint: '13/05/2023',
      timeOfComplaint: '12:59:00 AM',
      userId: 'userId',
      dustbinId: 'dustbinId',
    ),
    Complaint(
      title: 'comp 2',
      communityId: '65f82a819c8c2cceebe47723',
      status: 'resolved',
      description: 'description 2',
      dateOfComplaint: '13/05/2023',
      timeOfComplaint: '12:59:00 AM',
      userId: 'userId',
      dustbinId: 'dustbinId',
    ),
  ];

  List<Complaint> get complaints {
    return [..._complaints];
  }

  Future<void> getAllComplaints(userId, accessToken) async {
    String url = '$kApiURL/complaint/user/$userId';
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
      } else {
        print('Failed to get complaints');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addComplaint(userId, accessToken, Complaint complaint) async {
    String url = '$kApiURL/complaint';
    print('inside add complaint');
    print(complaint.title);
    print(userId);
    print(complaint.description);
    print(complaint.dateOfComplaint);
    print(complaint.timeOfComplaint);
    print(complaint.communityId);
    print(complaint.dustbinId);
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': accessToken,
        },
        body: {
          "title": complaint.title,
          "description": complaint.description,
          "dateOfComplaint": complaint.dateOfComplaint,
          "timeOfComplaint": complaint.timeOfComplaint,
          "userId": userId,
          "communityId": complaint.communityId,
          "dustbinId": complaint.dustbinId,
        },
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        print('Complaint added successfully');
      } else {
        print('Failed to add complaint');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
