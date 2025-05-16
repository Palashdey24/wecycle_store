import 'dart:ui';

class AppColor {
  static const Color kDefaultColor = Color.fromARGB(208, 26, 41, 65);

//It's Hex color code
  final hexPrimaryColor = "#1a5653".replaceAll('#', '0xff');
  final hexSecondColor = "#107869".replaceAll('#', '0xff');
  final hexDarkColor = "#08313a".replaceAll('#', '0xff');
  final hexLightColor = "#5cd85a".replaceAll('#', '0xff');

//It's for Colors

  static const Color kPrimaryColor = Color(0xff1a5653);
  static const Color kSecondColor = Color(0xff107869);
  static const Color kDarkColor = Color(0xff08313a);
  static const Color kLightColor = Color(0xff5cd85a);
}
