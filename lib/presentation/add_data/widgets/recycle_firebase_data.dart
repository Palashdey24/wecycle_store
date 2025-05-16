import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:wcycle_bd_store/common/dimensions/app_gaps.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/common/helper/firebase/widgets/firebase_dropdown_helper.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';

class RecycleFirebaseData extends StatefulWidget {
  const RecycleFirebaseData({super.key, required this.onLoadFn});
  final void Function(
    String proName,
    String proImpact,
    String proUri,
  ) onLoadFn;

  @override
  State<RecycleFirebaseData> createState() => _RecycleFirebaseDataState();
}

class _RecycleFirebaseDataState extends State<RecycleFirebaseData> {
  String? productName;
  String impactLevel = "N/A";
  String? productUri;
  bool dataLoad = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox.square(
          dimension: PhoneSize.deviceWidth(context) / 3,
          child: Card(
            color: AppColor.kDarkColor,
            child: !dataLoad
                ? (productUri != null)
                    ? Transform.rotate(
                        angle: -0.3, child: Image.network(productUri!))
                    : null
                : const LoadingIndicator(indicatorType: Indicator.ballRotate),
          ),
        ),
        const Gap(largeGap),
        Row(
          children: [
            Expanded(
                child: Container(
              height: AppGaps.largeGap + 20,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.kSecondColor),
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(10, 10))),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  const Gap(5),
                  const FaIcon(
                    FontAwesomeIcons.circleRadiation,
                    size: 25,
                    color: AppColor.kLightColor,
                  ),
                  const Gap(5),
                  Flexible(
                    child: Text(
                      "Impact Lv :",
                      style: AppFont.bodyMedium(context)
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  const Gap(5),
                  !dataLoad
                      ? Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            impactLevel.toString(),
                            style: AppFont.bodyMedium(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      : const LoadingIndicator(
                          indicatorType: Indicator.ballRotate),
                ],
              ),
            )),
            Expanded(
              child: FirebaseDropdownHelper(
                onDropdownFn: (value) async {
                  setState(() {
                    dataLoad = true;
                  });
                  productName = value;
                  final querySnap = await FirebaseFirestore.instance
                      .collection("recycleCategory")
                      .where('productName', isEqualTo: productName)
                      .get();
                  if (querySnap.docs.isNotEmpty) {
                    setState(() {
                      impactLevel = querySnap.docs[0]["impactLevel"];
                      productUri = querySnap.docs[0]["productImage"];
                      dataLoad = false;
                    });
                    widget.onLoadFn(productName!, impactLevel, productUri!);
                  }
                  return;
                },
                dropHint: "Select Product",
                dropLevel: "Product",
                fsCollection: "recycleCategory",
                fsField: "productName",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
