import 'package:intl/intl.dart';

class AppString {
  static const String kAppName = "WCycle Store";
  static const String kMapApi = "AIzaSyCweFD2YQ0_nq8ir8mKp9tUhu-vZFfkRxM";

  static final dateFormtter = DateFormat.yMMMEd();

  String formatedDate(DateTime date) {
    return dateFormtter.format(date);
  }
}
