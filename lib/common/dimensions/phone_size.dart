import 'package:flutter/cupertino.dart';

class PhoneSize {
  static double deviceWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double deviceHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
