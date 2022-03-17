import 'package:dippola/app_bar.dart';
import 'package:dippola/bottom_bar.dart';
import 'package:dippola/get_size.dart';
import 'package:dippola/navi_item.dart';
import 'package:dippola/privacy_policy/privacy_policy_relax_tour.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

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
              ProductScreen(),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: !isMobile(context) ? size.width * 0.8 : size.width * 0.9,
        child: isDesktop(context)
            ? DesktopProductList()
            : isTab(context)
                ? TabProductList()
                : MobileProductList(),
      ),
    );
  }
}

class DesktopProductList extends StatelessWidget {
  const DesktopProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DesktopProductItem(
                textSize: 17.0,
                title: '큐톡',
                img: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    'images/githubicon.png',
                    width: size.width * 0.1,
                  ),
                ),
                text:
                    '큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 ',
                onPressed: () {
                  LaunchUrl._launchURLRelaxTour();
                },
                privacyPressed: () {
                  Navigator.pushNamed(
                      context, '/product/cuetalk');
                },
              ),
            ),
            SizedBox(width: 30.0),
            Expanded(
              child: DesktopProductItem(
                textSize: 17.0,
                title: 'Relax Tour',
                img: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    'images/relaxtouricon.png',
                    width: size.width * 0.1,
                  ),
                ),
                text:
                'Are you not satisfied with your relaxation?\n\ndo you want your break time to be more efficient?\nThe solution is in this app Relax Tour',
                onPressed: () {
                  LaunchUrl._launchURLRelaxTour();
                },
                privacyPressed: () {
                  Navigator.pushNamed(
                      context, '/product/relax_tour_privacy_policy');
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: DesktopProductItem(
                textSize: 15.0,
                title: '나훈아 노래모음',
                img: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    'images/nhaicon.png',
                    width: size.width * 0.1,
                  ),
                ),
                text:
                '국민가수 나훈아 노래를 인기순으로 볼 수 있습니다.\n나훈아 팬분들의 연령을 감안해 최대한 간단한 조작법으로 재작되었습니다.\n나훈아의 모든 노래를 영상과 함께 무료로 감상하세요!',
                onPressed: () {
                  LaunchUrl._launchURLNha();
                },
                privacyPressed: () {
                  Navigator.pushNamed(context, '/product/nha_privacy_policy');
                },
              ),
            ),
            SizedBox(width: 30.0),
            Expanded(
              child: DesktopProductItem(
                textSize: 15.0,
                title: '해결의 책',
                img: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    'images/bookicon.png',
                    width: size.width * 0.1,
                  ),
                ),
                text:
                    '말 못할 고민이 있을 때, 중요한 결정을 해야할 때, 결정을 앞두고 망설이고 있을 때\n해결의 책은 당신의 고민을 해결 할 수 있게 도와줍니다.\n지금 해결의 책을 펼쳐보세요!',
                onPressed: () {
                  LaunchUrl._launchURLBook();
                },
                privacyPressed: () {
                  null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TabProductList extends StatelessWidget {
  const TabProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabProductItem(
          title: '큐톡',
          img: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.asset(
              'images/githubicon.png',
              width: 130,
            ),
          ),
          text:
          '큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 ',
          textSize: 14.0,
          onPressed: () {
            LaunchUrl._launchURLNha();
          },
          privacyPressed: () {
            Navigator.pushNamed(
                context, '/product/cuetalk');
          },
        ),
        SizedBox(height: 30.0),
        TabProductItem(
          title: 'Relax Tour',
          img: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.asset(
              'images/relaxtouricon.png',
              width: 130,
            ),
          ),
          text:
              'Are you not satisfied with your relaxation?\n\ndo you want your break time to be more efficient?\nThe solution is in this app Relax Tour',
          textSize: 17.0,
          onPressed: () {
            LaunchUrl._launchURLRelaxTour();
          },
          privacyPressed: () {
            Navigator.pushNamed(context, '/product/relax_tour_privacy_policy');
          },
        ),
        SizedBox(height: 30.0),
        TabProductItem(
          title: '나훈아 노래모음',
          img: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.asset(
              'images/nhaicon.png',
              width: 130,
            ),
          ),
          text:
              '국민가수 나훈아 노래를 인기순으로 볼 수 있습니다.\n\n나훈아 팬분들의 연령을 감안해 최대한 간단한 조작법으로 재작되었습니다.\n나훈아의 모든 노래를 영상과 함께 무료로 감상하세요!',
          textSize: 14.0,
          onPressed: () {
            LaunchUrl._launchURLNha();
          },
          privacyPressed: () {
            Navigator.pushNamed(context, '/product/nha_privacy_policy');
          },
        ),
        SizedBox(height: 30.0),
        TabProductItem(
          title: '해결의 책',
          img: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.asset(
              'images/bookicon.png',
              width: 130,
            ),
          ),
          text:
              '말 못할 고민이 있을 때, 중요한 결정을 해야할 때, 결정을 앞두고 망설이고 있을 때\n해결의 책은 당신의 고민을 해결 할 수 있게 도와줍니다.\n지금 해결의 책을 펼쳐보세요!',
          textSize: 14.0,
          onPressed: () {
            LaunchUrl._launchURLNha();
          },
          privacyPressed: () {
            null;
          },
        ),
      ],
    );
  }
}

class MobileProductList extends StatelessWidget {
  const MobileProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        MobileProductItem(
          img:
          Image.asset('images/githubicon.png', width: size.width * 0.27),
          title: '큐톡',
          text:
          '큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 ',
          size: size,
          onPressed: () {
            LaunchUrl._launchURLRelaxTour();
          },
          privacyPressed: () {
            Navigator.pushNamed(
                context, '/product/cuetalk');
          },
        ),
        SizedBox(height: 20.0),
        MobileProductItem(
          img:
              Image.asset('images/relaxtouricon.png', width: size.width * 0.27),
          title: 'Relax Tour',
          text:
              'Are you not satisfied with your relaxation?\n\ndo you want your break time to be more efficient?\nThe solution is in this app Relax Tour',
          size: size,
          onPressed: () {
            LaunchUrl._launchURLRelaxTour();
          },
          privacyPressed: () {
            Navigator.pushNamed(context, '/product/relax_tour_privacy_policy');
          },
        ),
        SizedBox(height: 20.0),
        MobileProductItem(
          img: Image.asset('images/nhaicon.png', width: size.width * 0.27),
          title: '나훈아 노래모음',
          text:
              '국민가수 나훈아 노래를 인기순으로 볼 수 있습니다.\n\n나훈아 팬분들의 연령을 감안해 최대한 간단한 조작법으로 재작되었습니다.\n나훈아의 모든 노래를 영상과 함께 무료로 감상하세요!',
          size: size,
          onPressed: () {
            LaunchUrl._launchURLNha();
          },
          privacyPressed: () {
            Navigator.pushNamed(context, '/product/nha_privacy_policy');
          },
        ),
        SizedBox(height: 20.0),
        MobileProductItem(
          img: Image.asset('images/bookicon.png', width: size.width * 0.27),
          title: '해결의 책',
          text:
              '말 못할 고민이 있을 때, 중요한 결정을 해야할 때, 결정을 앞두고 망설이고 있을 때\n해결의 책은 당신의 고민을 해결 할 수 있게 도와줍니다.\n지금 해결의 책을 펼쳐보세요!',
          size: size,
          onPressed: () {
            LaunchUrl._launchURLNha();
          },
          privacyPressed: () {
            null;
          },
        )
      ],
    );
  }
}

class DesktopProductItem extends StatelessWidget {
  const DesktopProductItem(
      {Key? key,
      required this.title,
      required this.img,
      required this.text,
      required this.textSize,
      required this.onPressed,
      required this.privacyPressed})
      : super(key: key);

  final String title;
  final Widget img;
  final String text;
  final double textSize;
  final GestureTapCallback onPressed;
  final GestureTapCallback privacyPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    img,
                    Text(title,
                        style: TextStyle(
                            color: Color.fromRGBO(5, 5, 100, 1.0),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0, bottom: 10.0, top: 20.0, left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SelectableText(
                            text,
                            style: TextStyle(fontSize: textSize),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: onPressed,
                              child: Text('VIEW MORE'),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(5, 5, 100, 1.0)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: privacyPressed, child: Text('Privacy Policy'))
            ],
          )
        ],
      ),
    );
  }
}

class TabProductItem extends StatelessWidget {
  const TabProductItem(
      {Key? key,
      required this.title,
      required this.img,
      required this.text,
      required this.textSize,
      required this.onPressed,
      required this.privacyPressed})
      : super(key: key);

  final String title;
  final Widget img;
  final String text;
  final double textSize;
  final GestureTapCallback onPressed;
  final GestureTapCallback privacyPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
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
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    img,
                    Text(title,
                        style: TextStyle(
                            color: Color.fromRGBO(5, 5, 100, 1.0),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SelectableText(
                            text,
                            style: TextStyle(fontSize: textSize),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: onPressed,
                              child: Text('VIEW MORE'),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(5, 5, 100, 1.0)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: privacyPressed, child: Text('Privacy Policy'))
            ],
          )
        ],
      ),
    );
  }
}

class MobileProductItem extends StatelessWidget {
  const MobileProductItem(
      {Key? key,
      required this.img,
      required this.title,
      required this.text,
      required this.size,
      required this.onPressed,
      required this.privacyPressed})
      : super(key: key);

  final Widget img;
  final String title;
  final String text;
  final Size size;
  final GestureTapCallback onPressed;
  final GestureTapCallback privacyPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1),
              color: Colors.grey)
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
      child: Column(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(30.0), child: img),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(
                fontSize: 18.0,
                color: Color.fromRGBO(5, 5, 100, 1.0),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          SelectableText(
            text,
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: onPressed,
            child: Text('VIEW MORE'),
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(5, 5, 100, 1.0)),
          ),
          SizedBox(height: 20.0),
          TextButton(onPressed: privacyPressed, child: Text('Privacy Policy'))
        ],
      ),
    );
  }
}

class LaunchUrl {
  static void _launchURLRelaxTour() async {
    String _url =
        'https://play.google.com/store/apps/details?id=com.tistory.starcue.bgnoise';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  static void _launchURLNha() async {
    String _url =
        'https://play.google.com/store/apps/details?id=com.tistory.starcue.songgainb';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  static void _launchURLBook() async {
    String _url =
        'https://play.google.com/store/apps/details?id=com.tistory.starcue.solutionb';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}
