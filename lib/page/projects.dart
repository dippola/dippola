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
      return 'relaxtour';
    } else if (id == 2) {
      return 'pjhouse';
    } else if (id == 3) {
      return 'nha';
    } else if (id == 4) {
      return 'solution';
    } else {
      return '';
    }
  }
}

// class ProjectDesktopBox extends StatelessWidget {
//   const ProjectDesktopBox({Key? key, required this.img, required this.title, required this.text, required this.platforms, required this.policy, required this.termsandconditions, required this.git}) : super(key: key);
//
//   final String img;
//   final String title;
//   final String text;
//   final String platforms;
//   final String policy;
//   final String termsandconditions;
//   final String git;
//
//   @override
//   Widget build(BuildContext context) {
//     double w = DeviceSize.getWidth(context) * 0.395;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           width: w,
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(15.0), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(1, 1))]),
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
//                           width: w * 0.3,
//                           child: ClipRRect(borderRadius: BorderRadius.circular(15.0), child: Image.asset('images/relaxtouricon.png')),
//                         ),
//                         SizedBox(height: 8.0),
//                         Text('RelaxTour', style: GoogleFonts.kanit(color: main1HighLightColor, fontSize: 18.0)),
//                         SizedBox(height: 8.0),
//                         Container(height: 1.0, width: w * 0.3, color: lineColor),
//                       ],
//                     ),
//                     SizedBox(width: 10.0),
//                     Container(
//                       width: w*0.62,
//                         child: Text('Are you not satisfied with your relaxation?\n\ndo you want your break time to be more efficient?\nThe solution is in this app Relax Tour',
//                             style: GoogleFonts.kanit(fontSize: 17.0)))
//                   ],
//                 ),
//                 SizedBox(height: 10.0),
//                 Container(
//                   width: w*0.7,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(width: 30.0, child: InkWell(child: Image.asset('images/icon/playstoreicon.png'))),
//                       Container(width: 30.0, child: InkWell(child: Image.asset('images/icon/githubicon.png'))),
//                       Container(width: 30.0, child: InkWell(child: Image.asset('images/icon/playstoreicon.png'))),
//                       TextButton(onPressed: () {}, child: Text('Private Policy', style: GoogleFonts.kanit()))
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         Container(
//           width: w,
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(15.0), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(1, 1))]),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Text('alskjdf'),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ProductScreen extends StatelessWidget {
//   const ProductScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Center(
//       child: Container(
//         width: !isMobile(context) ? size.width * 0.8 : size.width * 0.9,
//         child: isDesktop(context)
//             ? DesktopProductList()
//             : isTab(context)
//                 ? TabProductList()
//                 : MobileProductList(),
//       ),
//     );
//   }
// }
//
// class DesktopProductList extends StatelessWidget {
//   const DesktopProductList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: DesktopProductItem(
//                 textSize: 17.0,
//                 title: '큐톡',
//                 img: ClipRRect(
//                   borderRadius: BorderRadius.circular(30.0),
//                   child: Image.asset(
//                     'images/githubicon.png',
//                     width: size.width * 0.1,
//                   ),
//                 ),
//                 text: '큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 ',
//                 onPressedPlaystore: () {
//                   null;
//                 },
//                 privacyPressed: () {
//                   null;
//                 },
//                 isViewMore: true,
//                 onPressedViewMore: () {
//                   Navigator.pushNamed(context, '/product/cuetalk');
//                 },
//               ),
//             ),
//             SizedBox(width: 30.0),
//             Expanded(
//               child: DesktopProductItem(
//                   textSize: 17.0,
//                   title: 'Relax Tour',
//                   img: ClipRRect(
//                     borderRadius: BorderRadius.circular(30.0),
//                     child: Image.asset(
//                       'images/relaxtouricon.png',
//                       width: size.width * 0.1,
//                     ),
//                   ),
//                   text:
//                       'Are you not satisfied with your relaxation?\n\ndo you want your break time to be more efficient?\nThe solution is in this app Relax Tour',
//                   onPressedPlaystore: () {
//                     LaunchUrl._launchURLRelaxTour();
//                   },
//                   privacyPressed: () {
//                     Navigator.pushNamed(
//                         context, '/product/relax_tour_privacy_policy');
//                   },
//                   isViewMore: false,
//                   onPressedViewMore: () {
//                     null;
//                   }),
//             ),
//           ],
//         ),
//         SizedBox(height: 20.0),
//         Row(
//           children: [
//             Expanded(
//               child: DesktopProductItem(
//                 textSize: 15.0,
//                 title: '나훈아 노래모음',
//                 img: ClipRRect(
//                   borderRadius: BorderRadius.circular(30.0),
//                   child: Image.asset(
//                     'images/nhaicon.png',
//                     width: size.width * 0.1,
//                   ),
//                 ),
//                 text:
//                     '국민가수 나훈아 노래를 인기순으로 볼 수 있습니다.\n나훈아 팬분들의 연령을 감안해 최대한 간단한 조작법으로 재작되었습니다.\n나훈아의 모든 노래를 영상과 함께 무료로 감상하세요!',
//                 onPressedPlaystore: () {
//                   LaunchUrl._launchURLNha();
//                 },
//                 privacyPressed: () {
//                   Navigator.pushNamed(context, '/product/nha_privacy_policy');
//                 },
//                 isViewMore: false,
//                 onPressedViewMore: () {},
//               ),
//             ),
//             SizedBox(width: 30.0),
//             Expanded(
//               child: DesktopProductItem(
//                 textSize: 15.0,
//                 title: '해결의 책',
//                 img: ClipRRect(
//                   borderRadius: BorderRadius.circular(30.0),
//                   child: Image.asset(
//                     'images/bookicon.png',
//                     width: size.width * 0.1,
//                   ),
//                 ),
//                 text:
//                     '말 못할 고민이 있을 때, 중요한 결정을 해야할 때, 결정을 앞두고 망설이고 있을 때\n해결의 책은 당신의 고민을 해결 할 수 있게 도와줍니다.\n지금 해결의 책을 펼쳐보세요!',
//                 onPressedPlaystore: () {
//                   LaunchUrl._launchURLBook();
//                 },
//                 privacyPressed: () {
//                   null;
//                 },
//                 isViewMore: false,
//                 onPressedViewMore: () {},
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class TabProductList extends StatelessWidget {
//   const TabProductList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TabProductItem(
//           title: '큐톡',
//           img: ClipRRect(
//             borderRadius: BorderRadius.circular(30.0),
//             child: Image.asset(
//               'images/githubicon.png',
//               width: 130,
//             ),
//           ),
//           text: '큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 ',
//           textSize: 14.0,
//           onPressedPlaystore: () {
//             null;
//           },
//           privacyPressed: () {
//             null;
//           },
//           isViewMore: true,
//           onPressedViewMore: () {
//             Navigator.pushNamed(context, '/product/cuetalk');
//           },
//         ),
//         SizedBox(height: 30.0),
//         TabProductItem(
//           title: 'Relax Tour',
//           img: ClipRRect(
//             borderRadius: BorderRadius.circular(30.0),
//             child: Image.asset(
//               'images/relaxtouricon.png',
//               width: 130,
//             ),
//           ),
//           text:
//               'Are you not satisfied with your relaxation?\n\ndo you want your break time to be more efficient?\nThe solution is in this app Relax Tour',
//           textSize: 17.0,
//           onPressedPlaystore: () {
//             LaunchUrl._launchURLRelaxTour();
//           },
//           privacyPressed: () {
//             Navigator.pushNamed(context, '/product/relax_tour_privacy_policy');
//           },
//           isViewMore: false,
//           onPressedViewMore: () {null;},
//         ),
//         SizedBox(height: 30.0),
//         TabProductItem(
//           title: '나훈아 노래모음',
//           img: ClipRRect(
//             borderRadius: BorderRadius.circular(30.0),
//             child: Image.asset(
//               'images/nhaicon.png',
//               width: 130,
//             ),
//           ),
//           text:
//               '국민가수 나훈아 노래를 인기순으로 볼 수 있습니다.\n\n나훈아 팬분들의 연령을 감안해 최대한 간단한 조작법으로 재작되었습니다.\n나훈아의 모든 노래를 영상과 함께 무료로 감상하세요!',
//           textSize: 14.0,
//           onPressedPlaystore: () {
//             LaunchUrl._launchURLNha();
//           },
//           privacyPressed: () {
//             Navigator.pushNamed(context, '/product/nha_privacy_policy');
//           },
//           isViewMore: false,
//           onPressedViewMore: () {null;},
//         ),
//         SizedBox(height: 30.0),
//         TabProductItem(
//           title: '해결의 책',
//           img: ClipRRect(
//             borderRadius: BorderRadius.circular(30.0),
//             child: Image.asset(
//               'images/bookicon.png',
//               width: 130,
//             ),
//           ),
//           text:
//               '말 못할 고민이 있을 때, 중요한 결정을 해야할 때, 결정을 앞두고 망설이고 있을 때\n해결의 책은 당신의 고민을 해결 할 수 있게 도와줍니다.\n지금 해결의 책을 펼쳐보세요!',
//           textSize: 14.0,
//           onPressedPlaystore: () {
//             LaunchUrl._launchURLBook();
//           },
//           privacyPressed: () {
//             null;
//           },
//           isViewMore: false,
//           onPressedViewMore: () {null;},
//         ),
//       ],
//     );
//   }
// }
//
// class MobileProductList extends StatelessWidget {
//   const MobileProductList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         MobileProductItem(
//           img: Image.asset('images/githubicon.png', width: size.width * 0.27),
//           title: '큐톡',
//           text: '큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 큐톡설명 ',
//           size: size,
//           onPressedPlaystore: () {
//             null;
//           },
//           privacyPressed: () {
//
//           },
//           isViewMore: true,
//           onPressedViewMore: () {
//             Navigator.pushNamed(context, '/product/cuetalk');
//           },
//         ),
//         SizedBox(height: 20.0),
//         MobileProductItem(
//           img:
//               Image.asset('images/relaxtouricon.png', width: size.width * 0.27),
//           title: 'Relax Tour',
//           text:
//               'Are you not satisfied with your relaxation?\n\ndo you want your break time to be more efficient?\nThe solution is in this app Relax Tour',
//           size: size,
//           onPressedPlaystore: () {
//             LaunchUrl._launchURLRelaxTour();
//           },
//           privacyPressed: () {
//             Navigator.pushNamed(context, '/product/relax_tour_privacy_policy');
//           },
//           isViewMore: false,
//           onPressedViewMore: () {null;},
//         ),
//         SizedBox(height: 20.0),
//         MobileProductItem(
//           img: Image.asset('images/nhaicon.png', width: size.width * 0.27),
//           title: '나훈아 노래모음',
//           text:
//               '국민가수 나훈아 노래를 인기순으로 볼 수 있습니다.\n\n나훈아 팬분들의 연령을 감안해 최대한 간단한 조작법으로 재작되었습니다.\n나훈아의 모든 노래를 영상과 함께 무료로 감상하세요!',
//           size: size,
//           onPressedPlaystore: () {
//             LaunchUrl._launchURLNha();
//           },
//           privacyPressed: () {
//             Navigator.pushNamed(context, '/product/nha_privacy_policy');
//           },
//           isViewMore: false,
//           onPressedViewMore: () {null;},
//         ),
//         SizedBox(height: 20.0),
//         MobileProductItem(
//           img: Image.asset('images/bookicon.png', width: size.width * 0.27),
//           title: '해결의 책',
//           text:
//               '말 못할 고민이 있을 때, 중요한 결정을 해야할 때, 결정을 앞두고 망설이고 있을 때\n해결의 책은 당신의 고민을 해결 할 수 있게 도와줍니다.\n지금 해결의 책을 펼쳐보세요!',
//           size: size,
//           onPressedPlaystore: () {
//             LaunchUrl._launchURLBook();
//           },
//           privacyPressed: () {
//             null;
//           },
//           isViewMore: false,
//           onPressedViewMore: () {null;},
//         )
//       ],
//     );
//   }
// }
//
// class DesktopProductItem extends StatelessWidget {
//   const DesktopProductItem(
//       {Key? key,
//       required this.title,
//       required this.img,
//       required this.text,
//       required this.textSize,
//       required this.onPressedPlaystore,
//       required this.privacyPressed,
//       required this.isViewMore,
//       required this.onPressedViewMore})
//       : super(key: key);
//
//   final String title;
//   final Widget img;
//   final String text;
//   final double textSize;
//   final GestureTapCallback onPressedPlaystore;
//   final GestureTapCallback privacyPressed;
//   final bool isViewMore;
//   final GestureTapCallback onPressedViewMore;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.0),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//                 spreadRadius: 1,
//                 blurRadius: 1,
//                 offset: Offset(1, 1),
//                 color: Colors.grey)
//           ]),
//       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     img,
//                     Text(title,
//                         style: TextStyle(
//                             color: Color.fromRGBO(5, 5, 100, 1.0),
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold)),
//                     SizedBox(
//                       height: 45.0,
//                       width: 45.0,
//                       child: IconButton(
//                         onPressed: onPressedPlaystore,
//                         icon: Image.asset('images/playstoreicon.png'),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         right: 10.0, bottom: 10.0, top: 20.0, left: 20.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: SelectableText(
//                             text,
//                             style: TextStyle(fontSize: textSize),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             isViewMore
//                                 ? ElevatedButton(
//                                     onPressed: onPressedViewMore,
//                                     child: Text('VIEW MORE'),
//                                     style: ElevatedButton.styleFrom(
//                                         primary:
//                                             Color.fromRGBO(5, 5, 100, 1.0)),
//                                   )
//                                 : Opacity(opacity: 0.0),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextButton(
//                   onPressed: privacyPressed, child: Text('Privacy Policy'))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class TabProductItem extends StatelessWidget {
//   const TabProductItem({
//     Key? key,
//     required this.title,
//     required this.img,
//     required this.text,
//     required this.textSize,
//     required this.onPressedPlaystore,
//     required this.privacyPressed,
//     required this.isViewMore,
//     required this.onPressedViewMore,
//   }) : super(key: key);
//
//   final String title;
//   final Widget img;
//   final String text;
//   final double textSize;
//   final GestureTapCallback onPressedPlaystore;
//   final GestureTapCallback privacyPressed;
//   final bool isViewMore;
//   final GestureTapCallback onPressedViewMore;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 275,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.0),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//                 spreadRadius: 1,
//                 blurRadius: 1,
//                 offset: Offset(1, 1),
//                 color: Colors.grey)
//           ]),
//       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     img,
//                     Text(title,
//                         style: TextStyle(
//                             color: Color.fromRGBO(5, 5, 100, 1.0),
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold)),
//                     SizedBox(
//                       height: 45.0,
//                       width: 45.0,
//                       child: IconButton(
//                         onPressed: onPressedPlaystore,
//                         icon: Image.asset('images/playstoreicon.png'),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: SelectableText(
//                             text,
//                             style: TextStyle(fontSize: textSize),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             isViewMore ? ElevatedButton(
//                               onPressed: onPressedViewMore,
//                               child: Text('VIEW MORE'),
//                               style: ElevatedButton.styleFrom(
//                                   primary: Color.fromRGBO(5, 5, 100, 1.0)),
//                             ) : Opacity(opacity: 0.0),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextButton(
//                   onPressed: privacyPressed, child: Text('Privacy Policy'))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class MobileProductItem extends StatelessWidget {
//   const MobileProductItem(
//       {Key? key,
//       required this.img,
//       required this.title,
//       required this.text,
//       required this.size,
//       required this.onPressedPlaystore,
//       required this.privacyPressed,
//       required this.isViewMore,
//       required this.onPressedViewMore,})
//       : super(key: key);
//
//   final Widget img;
//   final String title;
//   final String text;
//   final Size size;
//   final GestureTapCallback onPressedPlaystore;
//   final GestureTapCallback privacyPressed;
//   final bool isViewMore;
//   final GestureTapCallback onPressedViewMore;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size.width * 0.9,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.0),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//               spreadRadius: 1,
//               blurRadius: 1,
//               offset: Offset(1, 1),
//               color: Colors.grey)
//         ],
//       ),
//       padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
//       child: Column(
//         children: [
//           ClipRRect(borderRadius: BorderRadius.circular(30.0), child: img),
//           SizedBox(height: 10.0),
//           Text(
//             title,
//             style: TextStyle(
//                 fontSize: 18.0,
//                 color: Color.fromRGBO(5, 5, 100, 1.0),
//                 fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(
//             height: 45.0,
//             width: 45.0,
//             child: IconButton(
//               onPressed: onPressedPlaystore,
//               icon: Image.asset('images/playstoreicon.png'),
//             ),
//           ),
//           SizedBox(height: 20.0),
//           SelectableText(
//             text,
//             style: TextStyle(),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20.0),
//           isViewMore ?
//           ElevatedButton(
//             onPressed: onPressedViewMore,
//             child: Text('VIEW MORE'),
//             style: ElevatedButton.styleFrom(
//                 primary: Color.fromRGBO(5, 5, 100, 1.0)),
//           ) : Opacity(opacity: 0.0),
//           SizedBox(height: 20.0),
//           TextButton(onPressed: privacyPressed, child: Text('Privacy Policy'))
//         ],
//       ),
//     );
//   }
// }

// class LaunchUrl {
//   static void _launchURLRelaxTour() async {
//     String _url =
//         'https://play.google.com/store/apps/details?id=com.dippola.relaxtour';
//     await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
//   }
//
//   static void _launchURLNha() async {
//     String _url =
//         'https://play.google.com/store/apps/details?id=com.tistory.starcue.songgainb';
//     await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
//   }
//
//   static void _launchURLBook() async {
//     String _url =
//         'https://play.google.com/store/apps/details?id=com.tistory.starcue.solutionb';
//     await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
//   }
// }

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