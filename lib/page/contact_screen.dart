import 'package:dippola/app_bar.dart';
import 'package:dippola/bottom_bar.dart';
import 'package:dippola/get_size.dart';
import 'package:dippola/navi_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

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
              ContactUsScreen(),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController tecName = TextEditingController();
    TextEditingController tecEmail = TextEditingController();
    TextEditingController tecBody = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1),
                    color: Colors.grey)
              ]),
          width: !isMobile(context) ? size.width * 0.7 : size.width * 0.9,
          child: Padding(
            padding: !isMobile(context)
                ? const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0)
                : const EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelectableText(
                  'Contact',
                  style: TextStyle(
                      color: Color.fromRGBO(5, 5, 100, 1.0),
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: !isMobile(context)
                      ? EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0)
                      : EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  child: SelectableText(
                      "we're happy to answer any questions you have or provide you with an estimate. just send us a message in the from below with any questions you may have.",
                  style: TextStyle(height: 1.5),),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: tecName,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Your Name',
                      hintText: 'Name'),
                  autofocus: false,
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: tecEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Your Email',
                      hintText: 'We need your email to reply'),
                  autofocus: false,
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: tecBody,
                  keyboardType: TextInputType.multiline,
                  minLines: 12,
                  maxLines: 50,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Contact',
                      hintText: 'Contents'),
                  autofocus: false,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    String name = tecName.text;
                    String email = tecEmail.text;
                    String body = tecBody.text;
                    checkText(
                        context: context, email: email, name: name, body: body);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Send')
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      fixedSize: Size(100, 40)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future openEmail(
      {required String toEmail,
      required String subject,
      required String body}) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    await _launchUrl(url);
  }

  Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void checkText(
      {required BuildContext context,
      required String email,
      required String name,
      required String body}) {
    bool checkEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!checkEmail) {
      openSnackBar(context, 'Please check you email');
    } else if (name.length == 0) {
      openSnackBar(context, 'Please check you name');
    } else if (body.length == 0) {
      openSnackBar(context, 'Please check you body');
    } else {
      openEmail(
          toEmail: 'develiny9@gmail.com',
          subject: 'Dippola website contact to $name',
          body: 'email: $email \n $body');
    }
  }

  void openSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SelectableText(msg, textAlign: !isMobile(context) ? TextAlign.center : TextAlign.start),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.indigo,
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.lightBlueAccent,
        onPressed: () {},
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))
      ),
    ));
  }
}
