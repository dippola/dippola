import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_bar.dart';
import '../bottom_bar.dart';
import '../get_size.dart';
import '../navi_item.dart';
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

bool isLoading = true;
String text = "";
String routeName = "";
String title = "";

class PrivatePolicyPage extends StatefulWidget {
  const PrivatePolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivatePolicyPage> createState() => _PrivatePolicyPageState();
}

class _PrivatePolicyPageState extends State<PrivatePolicyPage> {
  final ProjectModel model = ProjectModel(0, "", "", "", "", "", "", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 150, maxWidth: 160),
        child: NavItem(),
      ),
      drawerEnableOpenDragGesture: false,
      body: isLoading ? Loading() : LoadingFinish()
    );
  }

  Widget Loading() {
    getData(context);
    double w = DeviceSize.getWidth(context);
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
                Center(
                  child: Container(
                    width: isDesktop(context) ? w*0.7 : isTab(context) ? w*0.8 : w*0.9,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new, color: main1HighLightColor)),
                            Text(''),
                            Opacity(opacity: 0.0, child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new))),
                          ],
                        ),
                        Container(height: 1.0, width: isDesktop(context) ? w*0.7 : isTab(context) ? w*0.8 : w*0.9),
                        Container(height: 500.0)
                      ],
                    ),
                  ),
                ),
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
                PrivatePolicy1(),
                BottomBar(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getData(BuildContext context) async {
    routeName = ModalRoute.of(context)!.settings.name!.split("/")[2];
    final snapshot = await FirebaseFirestore.instance.collection('projects').doc(routeName).get();
    text = snapshot.get('policy');
    title = snapshot.get('title');
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isLoading = true;
  }
}

class PrivatePolicy1 extends StatelessWidget {
  const PrivatePolicy1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = DeviceSize.getWidth(context);
    return Center(
      child: Container(
        width: isDesktop(context) ? w*0.7 : isTab(context) ? w*0.8 : w*0.9,
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios_new, color: main1HighLightColor)),
                Text(title.replaceAll("\\n", "\n") + ' Private Policy', style: GoogleFonts.kanit(fontWeight: FontWeight.bold, fontSize: 18.0)),
                Opacity(opacity: 0.0, child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new))),
              ],
            ),
            Container(height: 1.0, width: isDesktop(context) ? w*0.7 : isTab(context) ? w*0.8 : w*0.9),
            SizedBox(height: 20.0),
            Container(width: isDesktop(context) ? w*0.7 : isTab(context) ? w*0.8 : w*0.9, child: Text(text.replaceAll("\\n", "\n"), style: GoogleFonts.kanit()))
          ],
        ),
      ),
    );
  }
}