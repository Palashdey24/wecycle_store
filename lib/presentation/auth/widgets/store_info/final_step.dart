import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

import 'package:wcycle_bd_store/core/config/theme/gap.dart';

List<String> removeWidgets = ["storeLocationModel", "docPath", "logoPath"];

class FinalStep extends StatelessWidget {
  const FinalStep({super.key, required this.sEntity});
  final Map<String, dynamic> sEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: PhoneSize.deviceHeight(context) - 300,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150),
            children: [
              ...sEntity.entries.map(
                (e) => (removeWidgets.contains(e.key))
                    ? const Gap(0)
                    : Container(
                        margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            gradient: SweepGradient(
                                center: Alignment.bottomRight,
                                colors: [
                                  Colors.white,
                                  AppColor.kSecondColor,
                                ]),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(10, 10))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e.key.toString().toUpperCase(),
                                textAlign: TextAlign.center,
                                style: AppFont.bodySmall(context)
                                    .copyWith(color: AppColor.kDarkColor),
                              ),
                              const Gap(normalGap),
                              Text(
                                e.value.toString(),
                                textAlign: TextAlign.center,
                                style: AppFont.bodySmall(context)
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
