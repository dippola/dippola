import 'dart:async';

import 'package:dippola/app_bar.dart';
import 'package:dippola/bottom_bar.dart';
import 'package:dippola/get_size.dart';
import 'package:dippola/navi_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              Home1(),
              Home2(),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class Home1 extends StatelessWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isDesktop(context)
        ? Home1Desktop(context)
        : isTab(context)
            ? Home1Tab(context)
            : Home1Mobile(context);
  }

  Widget Home1Desktop(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: DeviceSize.getWidth(context) * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Welcome to ',
                      style: GoogleFonts.kanit(fontSize: 60.0),
                    ),
                    Text(
                      'Dippola',
                      style: GoogleFonts.kanit(fontSize: 60.0, color: main1HighLightColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 18.0),
                Text(
                  'Take a look our projects',
                  style: GoogleFonts.kanit(fontSize: 60.0, height: 1),
                ),
                SizedBox(height: 18.0),
                Text(
                  'I’m always open to discussing product work or partnership opportunities',
                  style: GoogleFonts.kanit(fontSize: 30.0),
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 470.0),
            width: DeviceSize.getWidth(context) * 0.3,
            child: Image.asset(
              'images/main1image.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget Home1Tab(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: DeviceSize.getWidth(context) * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DeviceSize.getWidth(context) >= 750
                    ? Row(
                        children: [
                          Text(
                            'Welcome to ',
                            style: GoogleFonts.kanit(fontSize: 40.0),
                          ),
                          Text(
                            'Dippola',
                            style: GoogleFonts.kanit(fontSize: 40.0, color: main1HighLightColor, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to ',
                            style: GoogleFonts.kanit(fontSize: 40.0),
                          ),
                          Text(
                            'Dippola',
                            style: GoogleFonts.kanit(fontSize: 40.0, color: main1HighLightColor, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                SizedBox(height: 15.0),
                Text(
                  'Take a look our projects',
                  style: GoogleFonts.kanit(fontSize: 40.0, height: 1.1),
                ),
                SizedBox(height: 15.0),
                Text(
                  'I’m always open to discussing product work or partnership opportunities',
                  style: GoogleFonts.kanit(fontSize: 23.0),
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 470.0),
            width: DeviceSize.getWidth(context) * 0.28,
            child: Image.asset(
              'images/main1image.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget Home1Mobile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 470.0),
              width: DeviceSize.getWidth(context) * 0.3,
              child: Image.asset(
                'images/main1image.png',
              ),
            ),
            SizedBox(height: 13.0),
            Container(
              width: DeviceSize.getWidth(context) * 0.8,
              child: Center(
                child: Column(
                  children: [
                    DeviceSize.getWidth(context) >= 350
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome to ',
                                style: GoogleFonts.kanit(fontSize: 30.0),
                              ),
                              Text(
                                'Dippola',
                                style: GoogleFonts.kanit(fontSize: 30.0, color: main1HighLightColor, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                'Welcome to ',
                                style: GoogleFonts.kanit(fontSize: 30.0),
                              ),
                              Text(
                                'Dippola',
                                style: GoogleFonts.kanit(fontSize: 30.0, color: main1HighLightColor, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                    SizedBox(height: 13.0),
                    Text(
                      'Take a look our projects',
                      style: GoogleFonts.kanit(fontSize: 30.0, height: 1.3),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 13.0),
                    Text(
                      'I’m always open to discussing product work or partnership opportunities',
                      style: GoogleFonts.kanit(fontSize: 23.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Home2 extends StatelessWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isDesktop(context)
        ? Home2Desktop(context)
        : isTab(context)
            ? Home2Tab(context)
            : Home2Mobile(context);
  }

  Widget Home2Desktop(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color.fromRGBO(5, 5, 150, 1.0), Color.fromRGBO(5, 5, 30, 1.0)]),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: DeviceSize.getWidth(context) * 0.4,
                  child: Text(
                    "Here are a few design projects I've worked on recently.\nWant to see more?",
                    style: GoogleFonts.kanit(color: Colors.white, fontSize: 25.0),
                  ),
                ),
                SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () {
                    if (ModalRoute.of(context)!.settings.name != '/projects') {
                      Navigator.pushNamed(context, '/projects');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          "Take a Tour",
                          style: GoogleFonts.kanit(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                )
              ],
            ),
            ProjectPageView(),
          ],
        ),
      ),
    );
  }

  Widget Home2Tab(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color.fromRGBO(5, 5, 150, 1.0), Color.fromRGBO(5, 5, 30, 1.0)]),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: DeviceSize.getWidth(context) * 0.4,
                  child: Text(
                    "Here are a few design projects I've worked on recently.\nWant to see more?",
                    style: GoogleFonts.kanit(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          "Take a Tour",
                          style: GoogleFonts.kanit(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                )
              ],
            ),
            ProjectPageView(),
          ],
        ),
      ),
    );
  }

  Widget Home2Mobile(BuildContext context) {
    double w = DeviceSize.getWidth(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color.fromRGBO(5, 5, 150, 1.0), Color.fromRGBO(5, 5, 30, 1.0)]),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: w >= 335 ? 10.0 : 3.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: DeviceSize.getWidth(context) * 0.8,
                child: Text(
                  "Here are a few design projects I've worked on recently.\nWant to see more?",
                  style: GoogleFonts.kanit(color: Colors.white, fontSize: 22.0), textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Take a Tour",
                        style: GoogleFonts.kanit(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              SizedBox(height: 25.0),
              ProjectPageView(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectPageView extends StatefulWidget {
  const ProjectPageView({Key? key}) : super(key: key);

  @override
  State<ProjectPageView> createState() => _ProjectPageViewState();
}

class _ProjectPageViewState extends State<ProjectPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String pages = '1/3';
  bool autoPage = true;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    double w = DeviceSize.getWidth(context);
    List<String> imageList;
    imageList = [
      'images/pageviewimages/relaxtourwidth.png',
      'images/pageviewimages/nhawidth.png',
      'images/pageviewimages/bookwidth.png',
    ];
    pageViewControl();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              if (_currentPage > 1) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  _currentPage--;
                  pages = '$_currentPage/3';
                });
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        Stack(
          children: [
            Container(
              width: isDesktop(context) ? w * 0.35 : isTab(context) ? w * 0.40 : w * 0.7,
              height: (isDesktop(context) ? w * 0.35 : isTab(context) ? w * 0.40 : w * 0.7) * 0.6,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          imageList[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
                onPageChanged: (index) {
                  _currentPage = index + 1;
                  setState(() {
                    pages = '$_currentPage/3';
                  });
                },
              ),
            ),
            Positioned(
              bottom: 5.0,
              right: 5.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                  child: Text(
                    pages,
                    style: GoogleFonts.kanit(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5.0,
              top: 5.0,
              child: autoPage ? Pause() : Play()
            )
          ],
        ),
        IconButton(
            onPressed: () {
              if (_currentPage < 3) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  _currentPage++;
                  pages = '$_currentPage/3';
                });
              }
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )),
      ],
    );
  }

  Widget Play() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
        child: IconButton(
          onPressed: () {
            setState(() {
              autoPage = true;
            });
          },
          icon: Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget Pause() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
        child: IconButton(
          onPressed: () {
            setState(() {
              autoPage = false;
            });
          },
          icon: Icon(
            Icons.pause,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void pageViewControl() {
    if (autoPage) {
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        if (_currentPage != 3) {
          _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          setState(() {
            _currentPage++;
            pages = '$_currentPage/3';
          });
        } else {
          _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        }
      });
    } else {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }

}
