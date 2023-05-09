import 'dart:async';

import 'package:dippola/app_bar.dart';
import 'package:dippola/bottom_bar.dart';
import 'package:dippola/get_size.dart';
import 'package:dippola/navi_item.dart';
import 'package:flutter/material.dart';
import 'package:dippola/style.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

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
              About1(),
              SizedBox(height: 50.0),
              About2(),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class About1 extends StatelessWidget {
  const About1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isDesktop(context)
        ? About1Desktop(context)
        : isTab(context)
            ? About1Tab(context)
            : About1Mobile(context);
  }

  Widget About1Desktop(BuildContext context) {
    Widget About1Button(String img, GestureTapCallback onPressed) {
      return Container(
        width: 40.0,
        height: 40.0,
        child: InkWell(
          onTap: onPressed,
          child: Image.asset(img),
        ),
      );
    }

    var about1TextStyle = GoogleFonts.kanit(fontWeight: FontWeight.bold, fontSize: 23.0, height: 1.2);
    double w = DeviceSize.getWidth(context);
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white, boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 1, offset: Offset(1, 1), color: Colors.grey)]),
        width: w * 0.7,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(width: (w * 0.7) * 0.25, child: Image.asset('images/main1image.png')),
                  SizedBox(height: 15.0),
                  Text('Dippola', style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 25.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  Container(height: 1.0, width: (w * 0.7) * 0.25, color: lineColor),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      About1Button('images/icon/githubicon.png', () {}),
                      SizedBox(width: 20.0),
                      About1Button('images/icon/playstoreicon.png', () {}),
                    ],
                  )
                ],
              ),
              Container(
                width: (w * 0.7) * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dippola is a freelancer who lives in South Korea.', style: about1TextStyle),
                    SizedBox(height: 10.0),
                    Text("I'm developing a one-man developer app or web service. My area of expertise is developing hybrid web apps and Android native apps.", style: about1TextStyle),
                    SizedBox(height: 10.0),
                    Text("Let's make something special.", style: about1TextStyle)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget About1Tab(BuildContext context) {
    Widget About1Button(String img, GestureTapCallback onPressed) {
      return Container(
        width: 32.0,
        height: 32.0,
        child: InkWell(
          onTap: onPressed,
          child: Image.asset(img),
        ),
      );
    }

    var about1TextStyle = GoogleFonts.kanit(fontWeight: FontWeight.bold, fontSize: 18.0, height: 1.2);
    double w = DeviceSize.getWidth(context);
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white, boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 1, offset: Offset(1, 1), color: Colors.grey)]),
        width: w * 0.8,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(width: (w * 0.8) * 0.20, child: Image.asset('images/main1image.png')),
                  SizedBox(height: 15.0),
                  Text('Dippola', style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 25.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  Container(height: 1.0, width: (w * 0.8) * 0.2, color: lineColor),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      About1Button('images/icon/githubicon.png', () {}),
                      SizedBox(width: 20.0),
                      About1Button('images/icon/playstoreicon.png', () {}),
                    ],
                  )
                ],
              ),
              Container(
                width: (w * 0.7) * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dippola is a freelancer who lives in South Korea.', style: about1TextStyle),
                    SizedBox(height: 10.0),
                    Text("I'm developing a one-man developer app or web service. My area of expertise is developing hybrid web apps and Android native apps.", style: about1TextStyle),
                    SizedBox(height: 10.0),
                    Text("Let's make something special.", style: about1TextStyle)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget About1Mobile(BuildContext context) {
    Widget About1Button(String img, GestureTapCallback onPressed) {
      return Container(
        width: 30.0,
        height: 30.0,
        child: InkWell(
          onTap: onPressed,
          child: Image.asset(img),
        ),
      );
    }

    var about1TextStyle = GoogleFonts.kanit(fontWeight: FontWeight.bold, fontSize: 17.0, height: 1.2);
    double w = DeviceSize.getWidth(context);
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white, boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 1, offset: Offset(1, 1), color: Colors.grey)]),
        width: w * 0.9,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: (w * 0.9) * 0.35, child: Image.asset('images/main1image.png')),
              SizedBox(height: 15.0),
              Text('Dippola', style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 25.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              Container(height: 1.0, width: (w * 0.9) * 0.6, color: lineColor),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  About1Button('images/icon/githubicon.png', () {}),
                  SizedBox(width: 20.0),
                  About1Button('images/icon/playstoreicon.png', () {}),
                ],
              ),
              SizedBox(height: 10.0),
              Text('Dippola is a freelancer who lives in South Korea.', style: about1TextStyle),
              SizedBox(height: 10.0),
              Text("I'm developing a one-man developer app or web service. My area of expertise is developing hybrid web apps and Android native apps.", style: about1TextStyle),
              SizedBox(height: 10.0),
              Text("Let's make something special.", style: about1TextStyle)
            ],
          ),
        ),
      ),
    );
  }
}

class About2 extends StatelessWidget {
  const About2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = DeviceSize.getWidth(context);
    return !isMobile(context) ? About2DesktopTab(w) : About2Mobile(w);
  }

  Widget About2DesktopTab(double w) {
    Widget Text1(String text) {
      return Text(text, style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.start);
    }

    Widget Text2(String text) {
      return Text(text, style: GoogleFonts.kanit(fontSize: 17.0), textAlign: TextAlign.start);
    }

    return Center(
      child: Container(
        width: w * 0.7,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: (w * 0.7) * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text1('Practicality'), Text2('Our goal is to develop practical services that are helpful for daily life or work.')],
                  ),
                ),
                Container(width: (w * 0.7) * 0.45, child: Lottie.asset('images/lottie/about2anim1.json'))
              ],
            ),
            Container(height: 1.0, width: w * 0.7, color: lineColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(width: (w * 0.7) * 0.45, child: Lottie.asset('images/lottie/about2anim2.json')),
                Container(
                  width: (w * 0.7) * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text1('Creative'),
                      Text2('We provide services that can enhance the quality of life with creative ideas, enabling efficient use of time and providing a sense of relaxation in life.')
                    ],
                  ),
                ),
              ],
            ),
            Container(height: 1.0, width: w * 0.9, color: lineColor),
          ],
        ),
      ),
    );
  }

  Widget About2Mobile(double w) {
    Widget Text1(String text) {
      return Text(text, style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center);
    }

    Widget Text2(String text) {
      return Text(text, style: GoogleFonts.kanit(fontSize: 17.0), textAlign: TextAlign.center);
    }

    return Center(
      child: Container(
        width: w * 0.7,
        child: Column(
          children: [
            Container(width: w * 0.7, child: Lottie.asset('images/lottie/about2anim1.json')),
            Container(
              width: w * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text1('Practicality'), Text2('Our goal is to develop practical services that are helpful for daily life or work.')],
              ),
            ),
            SizedBox(height: 20.0),
            Container(height: 1.0, width: w * 0.7, color: lineColor),
            Container(width: w * 0.7, child: Lottie.asset('images/lottie/about2anim2.json')),
            Container(
              width: w * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text1('Creative'),
                  Text2('We provide services that can enhance the quality of life with creative ideas, enabling efficient use of time and providing a sense of relaxation in life.')
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(height: 1.0, width: w * 0.9, color: lineColor),
          ],
        ),
      ),
    );
  }
}