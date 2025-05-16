import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_theme.dart';
import 'package:wcycle_bd_store/presentation/auth/pages/auth_state_page.dart';

import 'package:wcycle_bd_store/core/config/utility/string/app_string.dart';

import 'firebase_options.dart';

final themeColor = ColorScheme.fromSeed(seedColor: AppColor.kPrimaryColor);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.kAppName,
      theme: AppTheme.appTheme.copyWith(
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
      home: const SafeArea(child: AuthStatePages()),
    );
  }
}
