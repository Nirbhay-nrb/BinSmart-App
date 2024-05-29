// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, avoid_print, use_key_in_widget_constructors

import 'package:binsmart/constants.dart';
import 'package:binsmart/providers/classes/complaint.dart';
import 'package:binsmart/providers/classes/dustbin.dart';
import 'package:binsmart/providers/routes/auth.dart';
import 'package:binsmart/providers/routes/complaints.dart';
import 'package:binsmart/providers/routes/dustbins.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResidentHomePage extends StatefulWidget {
  const ResidentHomePage({super.key});

  @override
  State<ResidentHomePage> createState() => _ResidentHomePageState();
}

class _ResidentHomePageState extends State<ResidentHomePage> {
  List<Complaint> complaints = [];
  List<Dustbin> dustbins = [];
  bool _isLoading = true;

  void initialiseComplaints() async {
    dustbins = Provider.of<Dustbins>(context, listen: false).dustbins;
    final userId = Provider.of<Auth>(context, listen: false).userId;
    final accessToken = Provider.of<Auth>(context, listen: false).accessToken;
    await Provider.of<Complaints>(context, listen: false)
        .getAllComplaints(userId, accessToken);
    complaints = Provider.of<Complaints>(context, listen: false).complaints;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    initialiseComplaints();
    super.initState();
  }

  void _scanQRCode() async {
    String? dustbinId = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRViewExample()),
    );

    if (dustbinId != null) {
      _showAddComplaintForm(dustbinId);
    }
  }

  void _showAddComplaintForm(String dustbinId) {
    final _formKey = GlobalKey<FormState>();
    String title = '';
    String description = '';
    String userId = Provider.of<Auth>(context, listen: false).userId;
    // String communityId = dustbins
    //     .firstWhere((element) => element.dustbinId == dustbinId)
    //     .communityId;
    String communityId = '65f82a819c8c2cceebe47723';
    print('insiide show add complaint form ::::: $communityId');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Complaint'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    title = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    description = value!;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Complaint newComplaint = Complaint(
                    title: title,
                    communityId: communityId,
                    status: 'pending',
                    description: description,
                    dateOfComplaint: DateTime.now().toString(),
                    timeOfComplaint: DateTime.now().toString(),
                    userId: userId,
                    dustbinId: dustbinId,
                  );

                  final accessToken =
                      Provider.of<Auth>(context, listen: false).accessToken;
                  await Provider.of<Complaints>(context, listen: false)
                      .addComplaint(userId, accessToken, newComplaint);

                  setState(() {
                    complaints.add(newComplaint);
                  });

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
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
              _scanQRCode();
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
                  return ListTile(
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
                  );
                },
              ),
            ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${result!.format}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controller.pauseCamera();
        Navigator.of(context).pop(result!.code);
      });
    });
  }
}
