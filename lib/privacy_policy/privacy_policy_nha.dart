import 'package:dippola/app_bar.dart';
import 'package:dippola/bottom_bar.dart';
import 'package:dippola/get_size.dart';
import 'package:dippola/navi_item.dart';
import 'package:dippola/privacy_policy/privacy_policy_text.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyNha extends StatelessWidget {
  const PrivacyPolicyNha({Key? key}) : super(key: key);

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
              PrivacyPolicyNhaDesktop(),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyNhaDesktop extends StatelessWidget {
  const PrivacyPolicyNhaDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        // width: size.width * 0.8,
        width: !isMobile(context) ? size.width * 0.8 : size.width * 0.9,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 20.0,
                ),
                Text('나훈아 노래모음'),
                Opacity(
                  opacity: 0.0,
                  child: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: 20.0,
                  ),
                )
              ],
            ),
            Divider(
              height: 30.0,
              thickness: 0.5,
            ),
            Container(
              // width: size.width * 0.7,
              width: !isMobile(context) ? size.width * 0.7 : size.width * 0.9,
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [SelectableText(NhaText.text, style: TextStyle(height: 1.5),)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
