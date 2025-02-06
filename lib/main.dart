import 'dart:html';

import 'package:dippola/page/about.dart';
import 'package:dippola/page/contact.dart';
import 'package:dippola/page/home.dart';
import 'package:dippola/page/ostranslator_delete_data.dart';
import 'package:dippola/page/projects.dart';
import 'package:dippola/page/terms_and_conditions.dart';
import 'package:dippola/page/test_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dippola/page/private_policy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();
  runApp(const MyDevWeb());
}

class MyDevWeb extends StatelessWidget {
  const MyDevWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dippola',
      theme: ThemeData(primaryColor: Colors.indigo),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/about": (context) => const AboutPage(),
        "/projects": (context) => const Product(),
        "/contact": (context) => const ContactPage(),
        "/projects/relaxtour/private_policy": (context) => const PrivatePolicyPage(),//1
        "/projects/pjhouse/private_policy": (context) => const PrivatePolicyPage(),//2
        "/projects/nha/private_policy": (context) => const PrivatePolicyPage(),//3
        "/projects/solution/private_policy": (context) => const PrivatePolicyPage(),//4
        "/projects/relaxtour/terms_and_conditions": (context) => const TacPage(),
        "/projects/onscreentranslator/private_policy": (context) => const PrivatePolicyPage(),
        "/projects/onscreentranslator/test_video": (context) => const TestVideo(),
        "/projects/onscreentranslator/delete_data": (context) => const DeleteDataPage(),



        // "/projects/relax_tour_privacy_policy": (context) => PrivacyPolicyRelaxTour(),
        // "/projects/nha_privacy_policy": (context) => PrivacyPolicyNha(),
        // "/projects/cuetalk": (context) => DetailCueTalk(),
        // "/projects/relax_tour_terms_and_conditions": (context) => TermsAndConditionsRelaxTour(),
      },
    );
  }
}