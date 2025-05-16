import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/common/helper/dialog_loading/dialogs_helper.dart';
import 'package:wcycle_bd_store/common/helper/navigator/app_navigator.dart';

import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';
import 'package:wcycle_bd_store/api/sign_api.dart';
import 'package:wcycle_bd_store/presentation/auth/pages/store_info_page.dart';
import 'package:wcycle_bd_store/common/widgets/fields/form_field_text.dart';

final signInHelpers = SignApis();

class CredentialFormContainer extends StatelessWidget {
  const CredentialFormContainer({super.key, required this.isSign});

  final bool isSign;
  static const String signInTxt = "Sign In";
  static const String signUpTxt = "Next";

  @override
  Widget build(BuildContext context) {
    final formKeyCre = GlobalKey<FormState>();

    String? emailAdrress;

    String? passCre;

    String? rePass;

    void onSaveCre() {
      if (formKeyCre.currentState!.validate()) {
        formKeyCre.currentState!.save();
        DialogsLoading.showProgressBar(context);
        if (isSign == true) {
          if (passCre != rePass) {
            DialogsLoading.removeMessage(context);
            DialogsLoading.showMessage(context,
                "Please check password are mismatch or Number not valid");
          } else {
            final userCreate = fsApis.firebaseAuth
                .createUserWithEmailAndPassword(
                    email: emailAdrress!, password: passCre!);

            userCreate.whenComplete(
              () {},
            );

            if (!context.mounted) return;
            Navigator.pop(context);
            AppNavigatior.navigatorPushWithTransition(
                context,
                StoreInfoPage(
                  emailAddress: emailAdrress ?? "",
                  password: passCre ?? "",
                ),
                const Offset(0, 1),
                Curves.easeInCubic);
          }
        } else {
          signInHelpers.signIn(context, emailAdrress!, passCre!);
          return;
        }
      }
    }

    return Form(
      key: formKeyCre,
      child: ListView(
        children: [
          const Gap(largeGap),
          Text(
            isSign ? "Create Account" : "Account LogIn",
            textAlign: TextAlign.center,
            style: AppFont.bodyMedium(context).copyWith(color: Colors.white),
          ),
          const Gap(mediumGap),
          FormFieldText(
            txtInType: TextInputType.text,
            vaildator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  value.trim().length < 4 ||
                  !value.trim().contains("@") ||
                  !value.trim().contains(".")) {
                return "Valid Email Address which contains @ and .";
              }
              return null;
            },
            onSave: (inputTxt) {
              emailAdrress = inputTxt.toLowerCase();
            },
            labelTxt: "Email Address",
            hint: "Please add Email address",
            icons: Icons.mark_email_unread_outlined,
            iconCol: Colors.orange.shade900,
          ),
          const Gap(normalGap),
          FormFieldText(
            txtInType: TextInputType.text,
            vaildator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  value.trim().length < 8) {
                return "Please add A Strong 8 char Pass";
              }
              return null;
            },
            onSave: (inputTxt) {
              passCre = inputTxt;
            },
            labelTxt: "Password",
            hint: "Please add Password",
            obscure: true,
            icons: Icons.key_outlined,
            iconCol: Colors.indigoAccent.shade400,
          ),
          const Gap(normalGap),
          Visibility(
            visible: isSign,
            child: FormFieldText(
              txtInType: TextInputType.text,
              labelTxt: "Repeat Password",
              onSave: (value) => rePass = value,
              hint: "Please input same Password",
              icons: Icons.key_off_outlined,
              iconCol: Colors.green.shade200,
            ),
          ),
          const Gap(normalGap),
          const Gap(largeGap),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                  onPressed: onSaveCre,
                  child: Text(
                    !isSign ? signInTxt : signUpTxt,
                  )),
            ),
          ),
          Visibility(visible: isSign, child: const Gap(largeGap + 30)),
        ],
      ),
    );
  }
}
