import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';

import 'package:wcycle_bd_store/common/widgets/btn/back_btn.dart';
import 'package:wcycle_bd_store/presentation/auth/widgets/store_info/stepper_info.dart';

class StoreInfoPage extends StatelessWidget {
  const StoreInfoPage({
    super.key,
    required this.emailAddress,
    required this.password,
  });
  final String emailAddress;
  final String password;

  Future<void> back(BuildContext context) async {
    await FirebaseAuth.instance.currentUser?.delete();
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: largeGap + 60,
              child: Image.asset("assets/welcome-stores.png"),
            ),
            BackBtn(
              onBtn: () => back(context),
            ),
            Container(
              margin: const EdgeInsets.only(top: largeGap + 60),
              decoration: const BoxDecoration(
                  color: AppColor.kPrimaryColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.elliptical(30, 30))),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                      height: PhoneSize.deviceHeight(context) - 100,
                      child: StepperInfo(
                        password: password,
                        emailAddress: emailAddress,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
