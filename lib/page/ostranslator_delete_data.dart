import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dippola/style.dart';
import 'package:flutter/material.dart';

import '../app_bar.dart';
import '../bottom_bar.dart';
import '../get_size.dart';
import '../navi_item.dart';

class DeleteDataPage extends StatelessWidget {
  const DeleteDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 150, maxWidth: 160),
        child: NavItem(),
      ),
      drawerEnableOpenDragGesture: false,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyAppBar(),
              DeleteData(),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteData extends StatefulWidget {
  const DeleteData({super.key});

  @override
  State<DeleteData> createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteData> {
  TextEditingController emailTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: isMobile(context) ? DeviceSize.getWidth(context) * 0.8 : DeviceSize.getWidth(context) * 0.5,
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Text(
              "OS Translator Delete User Data",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("Please enter the email of the user you want to delete and press the request button."),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: emailTextField,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)), labelText: 'Your Email', hintText: 'We need your email to reply'),
              autofocus: false,
            ),
            SizedBox(
              height: 25.0,
            ),
            IntrinsicWidth(
              child: ElevatedButton(
                onPressed: () async {
                  CollectionReference reference =FirebaseFirestore.instance.collection("ostranslator");
                  DocumentReference data =reference.doc(DateTime.now().toString());
                  try {
                    await data.set({'email': emailTextField.text});
                    print('Firestore data saved successfully.');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SuccessRequestDeleteDataDialog();
                        });
                  } catch (e) {
                    print('Failed to save Firestore data: $e');
                  }
                },
                child: Text(
                  "Request",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), fixedSize: Size(100, 40)),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessRequestDeleteDataDialog extends StatefulWidget {
  const SuccessRequestDeleteDataDialog({Key? key}) : super(key: key);

  @override
  State<SuccessRequestDeleteDataDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<SuccessRequestDeleteDataDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "Success Request",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
        ),
      ),
      content: Text(
        "The administration will notify you via email once the data deletion process is complete.",
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}