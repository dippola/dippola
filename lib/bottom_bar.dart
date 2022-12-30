import 'package:flutter/material.dart';
import 'package:dippola/get_size.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return (!isMobile(context) ? DesktopBottom() : MobileBottom());
    return Column(
      children: [
        !isMobile(context) ? DesktopBottom() : MobileBottom(),
        AboutDippola()
      ],
    );
  }
}

class DesktopBottom extends StatelessWidget {
  const DesktopBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {
                if (ModalRoute.of(context)!.settings.name != '/contact') {
                  Navigator.pushNamed(context, '/contact');
                }
              },
              child: Text('dippolas@gmail.com'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BottomItem(
                  title: 'bottom1',
                  tapEvent: () {},
                ),
                SizedBox(width: 10),
                BottomItem(
                  title: 'bottom2',
                  tapEvent: () {},
                ),
                SizedBox(width: 10),
                BottomItem(
                  title: 'bottom3',
                  tapEvent: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MobileBottom extends StatelessWidget {
  const MobileBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          BottomItem(
            title: 'bottom11',
            tapEvent: () {},
          ),
          SizedBox(height: 10),
          BottomItem(
            title: 'bottom22',
            tapEvent: () {},
          ),
          SizedBox(height: 10),
          BottomItem(
            title: 'bottom33',
            tapEvent: () {},
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              if (ModalRoute.of(context)!.settings.name != '/contact') {
                Navigator.pushNamed(context, '/contact');
              }
            },
            child: Text('develiny9@gmail.com'),
          )
        ],
      ),
    );
  }
}

class BottomItem extends StatelessWidget {
  const BottomItem({Key? key, required this.title, required this.tapEvent})
      : super(key: key);

  final String title;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ),
    );
  }
}

class AboutDippola extends StatelessWidget {
  const AboutDippola({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? MobileDetail() : DesktopDetail();
  }

  Widget DesktopDetail() {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              grey("회사명: "),
              black("디폴라"),
              grey("   |   사업자번호: "),
              black("833-32-01109"),
              checkButton()
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              grey("대표: "),
              black("김민준"),
              grey("   |   주소: "),
              black("인천시 서구 가현로97번길6")
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              grey("대표전화: "),
              black("070-8064-7420"),
              grey("   |   이메일: "),
              black("dippolas@gmail.com"),
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

  Widget MobileDetail() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            grey("회사명: "),
            black("디폴라"),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [grey("사업자번호: "), black("833-32-01109"), checkButton()],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            grey("대표: "),
            black("김민준"),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [grey("주소: "), black("인천시 서구 가현로97번길6")],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            grey("대표전화: "),
            black("010-3339-3988"),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            grey("이메일: "),
            black("dippolas@gmail.com"),
          ],
        ),
        SizedBox(height: 5),
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
    );
  }

  Widget black(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black),
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
    String _url =
        'http://www.ftc.go.kr/bizCommPop.do?wrkr_no=4845900206';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}