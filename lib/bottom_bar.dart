import 'package:dippola/style.dart';
import 'package:flutter/material.dart';
import 'package:dippola/get_size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return (!isMobile(context) ? DesktopBottom() : MobileBottom());
    return Column(
      children: [Bottom1(), Bottom2(), Bottom3()],
    );
  }
}

class Bottom1 extends StatelessWidget {
  const Bottom1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? Bottom1Mobile(context) : Bottom1DesktopTab(context);
  }

  Widget Bottom1DesktopTab(BuildContext context) {
    double w = DeviceSize.getWidth(context);
    return Padding(
      // padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 100.0),
      padding: EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 20.0),
      child: Container(
        width: isDesktop(context) ? w*0.6 : isTab(context) ? w*0.8 : w*0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitle('Contact Dippola'),
                TextButtonNormal(dippolaEmail, () {}),
                TextButtonNormal(dippolaPhoneNumber, () {_callPhoneNumber();}),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitle('Info'),
                TextButtonNormal('Home', () {
                  if (ModalRoute.of(context)!.settings.name != '/') {
                    Navigator.pushNamed(context, '/');
                  }
                }),
                TextButtonNormal('About', () {
                  if (ModalRoute.of(context)!.settings.name != '/about') {
                    Navigator.pushNamed(context, '/about');
                  }
                }),
                TextButtonNormal('Projects', () {
                  if (ModalRoute.of(context)!.settings.name != '/projects') {
                    Navigator.pushNamed(context, '/projects');
                  }
                }),
                TextButtonNormal('Contact', () {
                  if (ModalRoute.of(context)!.settings.name != '/contact') {
                    Navigator.pushNamed(context, '/contact');
                  }
                }),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitle('Projects'),
                TextButtonNormal('Relax Tour', () {}),
                TextButtonNormal('나훈아 노래모음', () {}),
                TextButtonNormal('해결의 책', () {}),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Bottom1Mobile(BuildContext context) {
    double w = DeviceSize.getWidth(context);
    return Padding(
      // padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 100.0),
      padding: EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 20.0),
      child: Container(
        width: isDesktop(context) ? w*0.6 : isTab(context) ? w*0.8 : w*0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextTitle('Contact Dippola'),
                TextButtonNormal(dippolaEmail, () {}),
                TextButtonNormal(dippolaPhoneNumber, () {_callPhoneNumber();}),
              ],
            ),
            SizedBox(height: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextTitle('Info'),
                TextButtonNormal('Home', () {
                  if (ModalRoute.of(context)!.settings.name != '/') {
                    Navigator.pushNamed(context, '/');
                  }
                }),
                TextButtonNormal('About', () {
                  if (ModalRoute.of(context)!.settings.name != '/about') {
                    Navigator.pushNamed(context, '/about');
                  }
                }),
                TextButtonNormal('Projects', () {
                  if (ModalRoute.of(context)!.settings.name != '/projects') {
                    Navigator.pushNamed(context, '/projects');
                  }
                }),
                TextButtonNormal('Contact', () {
                  if (ModalRoute.of(context)!.settings.name != '/contact') {
                    Navigator.pushNamed(context, '/contact');
                  }
                }),
              ],
            ),
            SizedBox(height: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextTitle('Projects'),
                TextButtonNormal('Relax Tour', () {}),
                TextButtonNormal('나훈아 노래모음', () {}),
                TextButtonNormal('해결의 책', () {}),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget TextTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 16.0),
    );
  }

  Widget TextButtonNormal(String text, GestureTapCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.kanit(fontSize: 16.0, color: Colors.black87),
      ),
      style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0), minimumSize: Size.zero),
    );
  }
}

class Bottom2 extends StatelessWidget {
  const Bottom2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? Bottom2Mobile(context) : Bottom2DesktopTab(context);
  }

  Widget Bottom2DesktopTab(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: DeviceSize.getWidth(context)*0.8,
            height: 1.0,
            color: lineColor,
          ),
          SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [black("Dippola"), grey("   |   Business Number: "), black("833-32-01109"), checkButton()],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [black("KIM MINJUN"), grey("   |   Address: "), black(dippolaAddress)],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              grey("Phone Number: "),
              black(dippolaPhoneNumber),
              grey("   |   Email: "),
              black(dippolaEmail),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              grey("fax: "),
              black("032-232-0999"),
            ],
          ),
          SizedBox(height: 30.0)
        ],
      ),
    );
  }

  Widget Bottom2Mobile(BuildContext context) {
    return Column(
      children: [
        Container(
          width: DeviceSize.getWidth(context)*0.8,
          height: 1.0,
          color: lineColor,
        ),
        SizedBox(height: 25.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            black("Dippola"),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [grey("Business Number: "), black("833-32-01109"), checkButton()],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            black("KIM MINJUN"),
          ],
        ),
        SizedBox(height: 10),
        Container(
          width: DeviceSize.getWidth(context)*0.95,
          child: DeviceSize.getWidth(context) >= 466 ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [grey("Address: "), black(dippolaAddress)],
          ) : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [grey("Address: "), black(dippolaAddress)],
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            grey("Phone: "),
            black(dippolaPhoneNumber),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            grey("Email: "),
            black(dippolaEmail),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            grey("fax: "),
            black("032-232-0999"),
          ],
        ),
        SizedBox(height: 20.0)
      ],
    );
  }

  Widget grey(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black54),
      textAlign: TextAlign.center,
    );
  }

  Widget black(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  Widget checkButton() {
    // return TextButton(onPressed: () {}, child: Text("사업자등록확인"), style: TextButton.styleFrom(primary: Colors.black54),);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        height: 17.0,
        child: ElevatedButton(
          onPressed: () {
            _launchURLCheckCompany();
          },
          child: Text(
            "사업자등록확인",
            style: TextStyle(fontSize: 11.0),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.black26),
        ),
      ),
    );
  }

  static void _launchURLCheckCompany() async {
    String _url = 'http://www.ftc.go.kr/bizCommPop.do?wrkr_no=4845900206';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}

class Bottom3 extends StatelessWidget {
  const Bottom3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Center(
        child: Text(license, style: GoogleFonts.prompt(fontSize: 12.0)),
      ),
    );
  }
}


Future<void> _callPhoneNumber() async {
  final pn = dippolaPhoneNumber;
  if (await canLaunch(pn)) {
    await launch(pn);
  } else {
    throw 'Could not launch $pn';
  }
}