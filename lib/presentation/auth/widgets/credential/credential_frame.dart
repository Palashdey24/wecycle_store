import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/common/cliper/bezier_curves_bottom.dart';
import 'package:wcycle_bd_store/common/cliper/bezier_curves_top.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';
import 'package:wcycle_bd_store/presentation/auth/widgets/credential/credential_btn.dart';
import 'package:wcycle_bd_store/presentation/auth/widgets/credential/credential_form_container.dart';
import 'package:wcycle_bd_store/presentation/auth/widgets/credential/credential_text_container.dart';

final fontHelpers = AppFont();

class CredentialFrame extends StatefulWidget {
  const CredentialFrame({super.key});

  @override
  State<CredentialFrame> createState() => _CredentialFrameState();
}

class _CredentialFrameState extends State<CredentialFrame> {
  bool isSign = false;
  static const String signInTxt = "Sign In";
  static const String signUpTxt = "Sign Up";
  static const int kCredentialDuration = 1500;

  @override
  Widget build(BuildContext context) {
    final halfHeights = PhoneSize.deviceHeight(context) / 2;
    final widths = PhoneSize.deviceWidth(context);
    return Stack(
      children: [
        AnimatedPositioned(
            top: isSign ? 0 : halfHeights,
            height: halfHeights,
            duration: const Duration(milliseconds: kCredentialDuration),
            child: ClipPath(
              clipper: !isSign ? BezierCurvesTop() : BezierCurvesBottom(),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                        bottom:
                            isSign ? const Radius.circular(20) : Radius.zero,
                        top:
                            !isSign ? const Radius.circular(20) : Radius.zero)),
                width: widths,
                height: halfHeights,
                padding: const EdgeInsets.all(0),
                duration: const Duration(milliseconds: kCredentialDuration),
                child: CredentialTextContainer(
                  isSign: isSign,
                  btnWidgets: InkWell(
                    onTap: () {
                      setState(() {
                        isSign = !isSign;
                      });
                    },
                    child: CredentialBtn(
                      signText: isSign ? signInTxt : signUpTxt,
                    ),
                  ),
                ),
              ),
            )),
        AnimatedPositioned(
            top: !isSign ? 0 : halfHeights,
            height: halfHeights,
            duration: const Duration(milliseconds: kCredentialDuration),
            child: Container(
              padding: const EdgeInsets.all(normalGap),
              alignment: isSign ? Alignment.topCenter : Alignment.bottomCenter,
              width: widths,
              color: Colors.white,
              child: CredentialFormContainer(isSign: isSign),
            ))
      ],
    );
  }
}
