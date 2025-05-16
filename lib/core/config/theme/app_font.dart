import 'package:flutter/material.dart';

class AppFont {
  static TextStyle bodyLarge(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontSize: 25, fontWeight: FontWeight.bold);
  }

  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontSize: 15, fontWeight: FontWeight.bold);
  }

  static TextStyle bodySmall(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodySmall!
        .copyWith(fontSize: 10, fontWeight: FontWeight.bold);
  }
}
