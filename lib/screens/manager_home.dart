// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:binsmart/constants.dart';
import 'package:binsmart/providers/classes/cleaner.dart';
import 'package:binsmart/providers/classes/complaint.dart';
import 'package:binsmart/providers/classes/dustbin.dart';
import 'package:binsmart/providers/routes/auth.dart';
import 'package:binsmart/providers/routes/cleaners.dart';
import 'package:binsmart/providers/routes/complaints.dart';
import 'package:binsmart/providers/routes/dustbins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key});

  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  List<Dustbin> dustbins = [];
  List<Complaint> complaints = [];
  List<Cleaner> cleaners = [];
  bool _dustbinPage = true;
  bool _isLoading = true;

  void initialiseCleaners() async {
    final communityId =
        Provider.of<Auth>(context, listen: false).currentManager.communityId;
    await Provider.of<Cleaners>(context, listen: false)
        .getCleanersOfCommunity(communityId);
    cleaners = Provider.of<Cleaners>(context, listen: false).cleaners;
  }

  void initialiseDustbins() async {
    final userId = Provider.of<Auth>(context, listen: false).userId;
    final accessToken = Provider.of<Auth>(context, listen: false).accessToken;
    await Provider.of<Dustbins>(context, listen: false)
        .getDustbinsOfCommunity(userId, accessToken);
    dustbins = Provider.of<Dustbins>(context, listen: false).dustbins;
    setState(() {
      _isLoading = false;
    });
  }

  void initialiseComplaints() async {
    final userId = Provider.of<Auth>(context, listen: false).userId;
    final accessToken = Provider.of<Auth>(context, listen: false).accessToken;
    await Provider.of<Complaints>(context, listen: false)
        .getAllComplaints(userId, accessToken);
    complaints = Provider.of<Complaints>(context, listen: false).complaints;
  }

  @override
  void initState() {
    initialiseComplaints();
    initialiseCleaners();
    initialiseDustbins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _dustbinPage
        ? Scaffold(
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
                  icon: const Icon(Icons.forum, color: kBlack),
                  onPressed: () {
                    // display complaints page
                    setState(() {
                      _dustbinPage = false;
                    });
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
                            // display a dropdown menu to assign a cleaner
                            showMenu(
                              context: context,
                              position:
                                  RelativeRect.fromLTRB(100, 100, 100, 100),
                              items: cleaners.map((Cleaner cleaner) {
                                return PopupMenuItem<String>(
                                  value: cleaner.userId,
                                  child: Text(cleaner.name),
                                );
                              }).toList(),
                            ).then((String? selectedUserId) {
                              if (selectedUserId != null) {
                                // Assign the selected cleaner to the dustbin
                                setState(() {
                                  dustbins[index].cleanerId = selectedUserId;
                                });
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: (int.parse(
                                            dustbins[index].filledStatus) <=
                                        50)
                                    ? Colors.green
                                    : int.parse(dustbins[index].filledStatus) <=
                                            75
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
                                    ),
                                    Row(
                                      children: [
                                        Text('Assigned Cleaner : '),
                                        SizedBox(width: 15),
                                        (dustbins[index].cleanerId != "")
                                            ? Text(cleaners
                                                .firstWhere((cleaner) =>
                                                    cleaner.userId ==
                                                    dustbins[index].cleanerId)
                                                .name)
                                            : Text("Not assgined"),
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
          )
        : Scaffold(
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
                  icon: const Icon(Icons.delete, color: kBlack),
                  onPressed: () {
                    // display dustbins page
                    setState(() {
                      _dustbinPage = true;
                    });
                  },
                )
              ],
              title: Text(
                'Complaints',
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
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                  100, 100, 100, 100), // Fixed position
                              items: [
                                PopupMenuItem<String>(
                                  value: 'pending',
                                  child: Text('Pending'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'resolved',
                                  child: Text('Resolved'),
                                ),
                              ],
                            ).then((String? selectedStatus) {
                              if (selectedStatus != null) {
                                // Update the status of the complaint
                                setState(() {
                                  complaints[index].status = selectedStatus;
                                });
                              }
                            });
                          },
                          child: ListTile(
                            title: Text(complaints[index].title),
                            subtitle: Text(complaints[index].description),
                            trailing: Text(
                              complaints[index].status,
                              style: TextStyle(
                                color: complaints[index].status == 'pending'
                                    ? kRed
                                    : kGreen,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          );
  }
}
