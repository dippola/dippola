import 'package:dippola/get_size.dart';
import 'package:flutter/material.dart';

import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';
import 'package:scroll_page_view/scroll_page.dart';

import 'package:url_launcher/url_launcher.dart';

class ViewPager extends StatefulWidget {
  const ViewPager({Key? key}) : super(key: key);

  @override
  _ViewPagerState createState() => _ViewPagerState();
}

class _ViewPagerState extends State<ViewPager> {
  @override
  Widget build(BuildContext context) {
    return ViewPagerScreen();
  }
}

class ViewPagerScreen extends StatefulWidget {
  const ViewPagerScreen({Key? key}) : super(key: key);

  @override
  State<ViewPagerScreen> createState() => _ViewPagerScreen();
}

class _ViewPagerScreen extends State<ViewPagerScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final PageController pageController =
        PageController(initialPage: 1, keepPage: true);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(5, 5, 150, 1.0),
              Color.fromRGBO(5, 5, 30, 1.0)
            ]),
      ),
      // width: double.infinity,
      // height: (!isMobile(context) ? 380 : 300),
      padding: (!isMobile(context)
          ? EdgeInsets.symmetric(vertical: 25.0, horizontal: 60.0)
          : EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0)),
      child: (!isMobile(context)
          ? IsDesktopViewScreen(size: size)
          : IsMobileViewPageScreen(size: size)),
    );
  }
}

class IsMobileViewPageScreen extends StatelessWidget {
  const IsMobileViewPageScreen({Key? key, required this.size})
      : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewPagerText(),
        SizedBox(height: 20),
        MyCustomScrollView(size: size)
      ],
    );
  }
}

class IsDesktopViewScreen extends StatelessWidget {
  const IsDesktopViewScreen({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [ViewPagerText(), MyCustomScrollView(size: size)],
    );
  }
}

class MyCustomScrollView extends StatelessWidget {
  const MyCustomScrollView({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      //콘테이너 지워보기
      // padding: (!isMobile(context) ? EdgeInsets.only(right: 20) : EdgeInsets.all(0)),
      width: (!isMobile(context) ? size.width * 0.45 : size.width * 1),
      height: (!isMobile(context) ? 300 : 300),
      // constraints: BoxConstraints(maxWidth: size.width * 0.4),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: (!isMobile(context) ? 300 : 250),
              child: ScrollPageView(
                controller: ScrollPageController(),
                // children: _images.map((image) => _imageView(image)).toList(),
                children: [
                  InkWell(
                    onTap: () {
                      _launchURL(
                          'https://play.google.com/store/apps/details?id=com.tistory.starcue.bgnoise');
                    },
                    child: Image.asset(
                      'images/relaxtourwidth.png',
                      // width: (!isMobile(context) ? size.width * 0.45 : size.width * 0.9),
                      // height: (!isMobile(context) ? 300 : 250),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _launchURL('https://play.google.com/store/apps/details?id=com.tistory.starcue.songgainb');
                    },
                    child: Image.asset(
                      'images/nhawidth.png',
                      // width: (!isMobile(context) ? size.width * 0.45 : size.width * 0.9),
                      // height: (!isMobile(context) ? 300 : 250),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _launchURL('https://play.google.com/store/apps/details?id=com.tistory.starcue.solutionb');
                    },
                    child: Image.asset(
                      'images/bookwidth.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}

class ViewPagerText extends StatelessWidget {
  const ViewPagerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (!isMobile(context)
          ? Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Here are a few design projects I've worked on recently.\nWant to see more?",
                  textAlign: TextAlign.start,
                  maxLines: 10,
                  style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5),
                ),
                SizedBox(height: 15),
                ViewPagerButton()
              ],
            ))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Here are a few design projects I've worked on recently.\nWant to see more?",
                    textAlign: TextAlign.center,
                    maxLines: 10,
                    style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5),
                  ),
                ),
                SizedBox(height: 15),
                ViewPagerButton()
              ],
            )),
    );
  }
}

class ViewPagerButton extends StatelessWidget {
  const ViewPagerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/product');
        },
        child: Text('Take a tour'),
        style: ElevatedButton.styleFrom(
            primary: Colors.indigo,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            fixedSize: Size(130, 40)));
  }
}
