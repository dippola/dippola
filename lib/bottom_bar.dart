import 'package:flutter/material.dart';
import 'package:dippola/get_size.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!isMobile(context) ? DesktopBottom() : MobileBottom());
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
              child: Text('develiny9@gmail.com'),
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
