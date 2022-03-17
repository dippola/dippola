import 'package:dippola/page/about_screen.dart';
import 'package:dippola/page/contact_screen.dart';
import 'package:dippola/page/home_sceen.dart';
import 'package:dippola/page/product_screen.dart';
import 'package:dippola/privacy_policy/privacy_policy_nha.dart';
import 'package:dippola/privacy_policy/privacy_policy_relax_tour.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyDevWeb());
}

class MyDevWeb extends StatelessWidget {
  const MyDevWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dippola',
      theme: ThemeData(primaryColor: Colors.indigo),
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomePage(),
        "/about": (context) => AboutUs(),
        "/product": (context) => Product(),
        "/contact": (context) => ContactUs(),
        "/product/relax_tour_privacy_policy": (context) => PrivacyPolicyRelaxTour(),
        "/product/nha_privacy_policy": (context) => PrivacyPolicyNha()
      },
    );
  }
}
