import 'package:flutter/cupertino.dart';

class DeviceSize {
  static getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  static getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

var main1HighLightColor = Color(0xff4052b5);
var lineColor = Color(0xffd1d4e3);
var loadingColor = Color(0xffd9ddf6);

var dippolaPhoneNumber = '+8270-8046-7420';
var dippolaEmail = 'dippolas@gmail.com';
var dippolaAddress = '6, Gahyeon-ro 97beon-gil, Seo-gu, Incheon, Republic of Korea';