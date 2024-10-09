import 'package:dippola/app_bar.dart';
import 'package:dippola/bottom_bar.dart';
import 'package:dippola/get_size.dart';
import 'package:dippola/navi_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style.dart';

class ProjectModel implements Comparable<ProjectModel> {
  final int id;
  final String img;
  final String title;
  final String text;
  final String policy;
  final String platform;
  final String tac;
  final String git;

  ProjectModel(this.id, this.img, this.title, this.text, this.policy, this.platform, this.tac, this.git);

  @override
  int compareTo(ProjectModel other) {
    // TODO: implement compareTo
    return id.compareTo(other.id);
  }
}

List<ProjectModel>? projectList = [];
bool isLoading = true;

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (projectList!.length == 0) {
      getData();
    } else {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawerEnableOpenDragGesture: false,
        endDrawer: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 150, maxWidth: 160),
          child: NavItem(),
        ),
        drawerEnableOpenDragGesture: false,
        body: isLoading ? Loading() : LoadingFinish());
  }

  Widget Loading() {
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: CircularProgressIndicator(color: loadingColor),
          ),
        ),
        Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyAppBar(),
                ProjectLoading(),
                BottomBar(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget LoadingFinish() {
    return Stack(
      children: [
        Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyAppBar(),
                isDesktop(context) ? Project1Desktop() : isTab(context) ? Project1Tab() : Project1Mobile(),
                BottomBar(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getData() async {
    print('start!');
    final snapshot = await FirebaseFirestore.instance.collection('projects').get();
    final List<QueryDocumentSnapshot> documents = snapshot.docs;
    for (int i = 0; i < documents.length; i++) {
      final ProjectModel projectModel = ProjectModel(
          documents[i].get('id'), documents[i].get('img'), documents[i].get('title'), documents[i].get('text'), documents[i].get('policy'), documents[i].get('platform'), documents[i].get('tac'), documents[i].get('git'));
      projectList?.add(projectModel);
    }
    projectList!.sort();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    projectList = [];
    isLoading = true;
  }
}

class ProjectLoading extends StatelessWidget {
  const ProjectLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
    );
  }
}

class Project1Desktop extends StatelessWidget {
  const Project1Desktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = DeviceSize.getWidth(context);
    return Center(
      child: Container(
        width: w * 0.8,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: RowList(context)
            // children: [],
            ),
      ),
    );
  }

  List<Widget> RowList(BuildContext context) {
    List<Widget>? result = [];
    for (int i = 0; i < projectList!.length; i++) {
      if (i % 2 != 0) {
        //right
        result.add(ProjectDesktopBox(context, projectList![i - 1], projectList![i]));
      } else {
        //left
        if (i == projectList!.length - 1) {
          //last
          ProjectModel nullModel = ProjectModel(0, "", "", "", "", "", "", "");
          result.add(ProjectDesktopBox(context, projectList![i], nullModel));
        }
      }
    }
    return result;
  }

  Widget ProjectDesktopBox(BuildContext context, ProjectModel model1, ProjectModel model2) {
    double w = DeviceSize.getWidth(context) * 0.395;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
          width: w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.0), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(1, 1))]),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                          width: w * 0.3,
                          child: ClipRRect(borderRadius: BorderRadius.circular(15.0), child: Image.asset(model1.img)),
                        ),
                        SizedBox(height: 8.0),
                        Text(model1.title, style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 18.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.0),
                        Container(height: 1.0, width: w * 0.3, color: lineColor),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Container(width: w * 0.6, child: Text(model1.text.replaceAll("\\n", "\n"), style: GoogleFonts.kanit(fontSize: DeviceSize.getWidth(context) > 1270 ? 17.0 : 15.0), softWrap: true))
                  ],
                ),
                SizedBox(height: 15.0),
                BoxBottomIcons(model: model1)
              ],
            ),
          ),
        ),
        model2.title.length != 0
            ? Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
                width: w,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(15.0), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(1, 1))]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                                width: w * 0.3,
                                child: ClipRRect(borderRadius: BorderRadius.circular(15.0), child: Image.asset(model2.img)),
                              ),
                              SizedBox(height: 8.0),
                              Text(model2.title, style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 18.0, fontWeight: FontWeight.bold)),
                              SizedBox(height: 8.0),
                              Container(height: 1.0, width: w * 0.3, color: lineColor),
                            ],
                          ),
                          SizedBox(width: 10.0),
                          Container(width: w * 0.6, child: Text(model2.text.replaceAll("\\n", "\n"), style: GoogleFonts.kanit(fontSize: DeviceSize.getWidth(context) > 1270 ? 17.0 : 15.0)))
                        ],
                      ),
                      SizedBox(height: 15.0),
                      BoxBottomIcons(model: model2)
                    ],
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}

class Project1Tab extends StatelessWidget {
  const Project1Tab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = DeviceSize.getWidth(context);
    return Center(
      child: Container(
        width: w * 0.8,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: BoxList(context)
        ),
      ),
    );
  }

  List<Widget> BoxList(BuildContext context) {
    List<Widget> result = [];
    for (int i = 0; i < projectList!.length; i++) {
      result.add(ProjectTabBox(context, projectList![i]));
    }
    return result;
  }

  Widget ProjectTabBox(BuildContext context, ProjectModel model) {
    double w = DeviceSize.getWidth(context) * 0.8;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
          width: w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.0), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(1, 1))]),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                          width: w * 0.2,
                          child: ClipRRect(borderRadius: BorderRadius.circular(15.0), child: Image.asset(model.img)),
                        ),
                        SizedBox(height: 8.0),
                        Text(model.title, style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 18.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.0),
                        Container(height: 1.0, width: w * 0.3, color: lineColor),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Container(width: w * 0.62, child: Text(model.text.replaceAll("\\n", "\n"), style: GoogleFonts.kanit(fontSize: 17.0), softWrap: true))
                  ],
                ),
                SizedBox(height: 15.0),
                BoxBottomIcons(model: model)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Project1Mobile extends StatelessWidget {
  const Project1Mobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = DeviceSize.getWidth(context);
    return Center(
      child: Container(
        width: w * 0.8,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: BoxList(context)
        ),
      ),
    );
  }

  List<Widget> BoxList(BuildContext context) {
    List<Widget> result = [];
    for (int i = 0; i < projectList!.length; i++) {
      result.add(ProjectMobileBox(context, projectList![i]));
    }
    return result;
  }

  Widget ProjectMobileBox(BuildContext context, ProjectModel model) {
    double w = DeviceSize.getWidth(context) * 0.9;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
      width: w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.0), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(1, 1))]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
              width: w * 0.4,
              child: ClipRRect(borderRadius: BorderRadius.circular(15.0), child: Image.asset(model.img)),
            ),
            SizedBox(height: 8.0),
            Text(model.title, style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Container(height: 1.0, width: w * 0.7, color: lineColor),
            SizedBox(height: 10.0),
            Container(width: w * 0.8, child: Text(model.text.replaceAll("\\n", "\n"), style: GoogleFonts.kanit(fontSize: 16.0), softWrap: true)),
            SizedBox(height: 15.0),
            BoxBottomIcons(model: model)
          ],
        ),
      ),
    );
  }
}

class BoxBottomIcons extends StatelessWidget {
  const BoxBottomIcons({Key? key, required this.model}) : super(key: key);

  final ProjectModel model;

  @override
  Widget build(BuildContext context) {
    return !isMobile(context) ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: MyIconButton(model) + MyTextButton(context, model),
    ) : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: MyIconButton(model),
        ),
        SizedBox(height: 15.0),
        Container(height: 1.0, width: (DeviceSize.getWidth(context)*0.9)*0.7, color: lineColor),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: MyTextButton(context, model),
        )
      ],
    );
  }

  List<Widget> MyIconButton(ProjectModel model) {
    List<Widget> widgetList = [];
    List<String> platformList = model.platform.split(",");
    if (model.git != "n") {
      widgetList.add(
          Container(
            width: 30.0,
            child: InkWell(
              onTap: () {
                LaunchUrl._launchURLToGit(model.git);
              },
              child: Image.asset('images/icon/githubicon.png'),
            ),
          )
      );
    }
    for (int i = 0; i < platformList.length; i++) {
      if (platformList[i].split('!')[0] == 'playstore') {
        widgetList.add(
          Container(
            width: 30.0,
            child: InkWell(
              onTap: () {
                LaunchUrl._launchURLToPlaystore(platformList[i].split('!')[1]);
              },
              child: Image.asset('images/icon/playstoreicon.png'),
            ),
          ),
        );
      } else if (platformList[i].split('!')[0] == 'web') {
        widgetList.add(
          Container(
            width: 30.0,
            child: InkWell(
              onTap: () {
                LaunchUrl._launchURLToPlaystore(platformList[i].split('!')[1]);
              },
              child: Image.asset('images/icon/webicon.png'),
            ),
          ),
        );
      } else if (platformList[i].split('!')[0] == 'appstore') {
        widgetList.add(
          Container(
            width: 30.0,
            child: InkWell(
              onTap: () {
                LaunchUrl._launchURLToWeb(platformList[i].split('!')[1]);
              },
              child: Image.asset('images/icon/webicon.png'),
            ),
          ),
        );
      }
    }
    return widgetList;
  }

  List<Widget> MyTextButton(BuildContext context, ProjectModel model) {
    double w = DeviceSize.getWidth(context);
    List<Widget> widgetList = [];
    if (model.policy != 'n') {
      widgetList.add(TextButton(onPressed: () {
        Navigator.pushNamed(context, '/projects/' + getRouteName(model.id) + "/private_policy");
      }, child: Text('Private Policy', style: GoogleFonts.kanit(fontSize: w >= 650 ? 16.0 : w < 650 && w > 350 ? 13.0 : 11.0))));
    }
    if (model.tac != 'n') {
      widgetList.add(TextButton(onPressed: () {
        Navigator.pushNamed(context, '/projects/' + getRouteName(model.id) + "/terms_and_conditions");
      }, child: Text('Terms And Conditions', style: GoogleFonts.kanit(fontSize: w >= 650 ? 16.0 : w < 650 && w > 350 ? 13.0 : 11.0))));
    }
    return widgetList;
  }

  String getRouteName(int id) {
    if (id == 1) {
      return 'onscreentranslator';
    } else if (id == 2) {
      return 'relaxtour';
    } else if (id == 3) {
      return 'pjhouse';
    } else if (id == 4) {
      return 'nha';
    } else if (id==5) {
      return 'solution';
    }else {
      return '';
    }
  }
}

class LaunchUrl {
  static void _launchURLToGit(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
  static void _launchURLToPlaystore(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
  static void _launchURLToAppstore(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
  static void _launchURLToWeb(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}