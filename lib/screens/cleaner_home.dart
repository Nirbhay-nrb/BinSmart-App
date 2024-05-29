// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:binsmart/constants.dart';
import 'package:binsmart/providers/routes/auth.dart';
import 'package:binsmart/providers/routes/dustbins.dart';
import 'package:flutter/material.dart';
import 'package:binsmart/providers/classes/dustbin.dart';
import 'package:provider/provider.dart';

class CleanerHomePage extends StatefulWidget {
  const CleanerHomePage({super.key});

  @override
  State<CleanerHomePage> createState() => _CleanerHomePageState();
}

class _CleanerHomePageState extends State<CleanerHomePage> {
  List<Dustbin> dustbins = [];
  bool _isLoading = true;

  void initialiseDustbins() async {
    final userId = Provider.of<Auth>(context, listen: false).userId;
    final accessToken = Provider.of<Auth>(context, listen: false).accessToken;
    await Provider.of<Dustbins>(context, listen: false)
        .getDustbinsOfCleaner(userId, accessToken);
    dustbins = Provider.of<Dustbins>(context, listen: false).dustbins;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    initialiseDustbins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: kLightBgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left, color: kBlack),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code, color: kBlack),
            onPressed: () {
              // open qr code scanner and then forward to complaint form
            },
          )
        ],
        title: Text(
          'Dustbins',
          style: TextStyle(
            color: kBlack,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? CircularProgressIndicator()
          : Center(
              child: ListView.builder(
                itemCount: dustbins.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showConfirmationDialog(context, index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (int.parse(dustbins[index].filledStatus) <= 50)
                              ? Colors.green
                              : int.parse(dustbins[index].filledStatus) <= 75
                                  ? Colors.yellow
                                  : Colors.red),
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dustbins[index].location.building),
                              Text(dustbins[index].location.floor),
                              Text(dustbins[index].location.room),
                              Text(dustbins[index].location.description),
                              Row(
                                children: [
                                  Text(dustbins[index].lastCleanedDate),
                                  SizedBox(width: 15),
                                  Text(dustbins[index].lastCleanedTime),
                                ],
                              )
                            ],
                          ),
                          Text(dustbins[index].filledStatus),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _showConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Status Update'),
          content: Text('Is the dustbin clear?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                // Update the filledStatus of the dustbin back to 0
                setState(() {
                  dustbins[index].filledStatus = '0';
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
