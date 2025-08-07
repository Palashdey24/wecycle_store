import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/dimensions/app_gaps.dart';
import 'package:wcycle_bd_store/common/helper/navigator/app_navigator.dart';
import 'package:wcycle_bd_store/common/riverpod/indiviual_store_info_provider.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/presentation/add_data/pages/add_recycle_product_page.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/body_introduction_sections.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/page_frame.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/page_header.dart';
import 'package:wcycle_bd_store/presentation/overview/pages/overview_sections.dart';
import 'package:wcycle_bd_store/presentation/product/pages/product_section.dart';

const List<String> title = ["Product", "Services"];

final apis = FirebaseApi();

class HomePages extends ConsumerWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopData = ref.read(individualStoreProvider);
    void onBtn(Widget navWidget) {
      AppNavigatior.navigatorPushWithTransition(
          context, navWidget, const Offset(0, -1), Curves.easeInSine);
    }

    return PageFrame(pageWidgets: [
      const PageHeader(pageName: "Home"),
      const Gap(AppGaps.largeGap),
      const SizedBox(height: 200, child: OverviewSections()),
      const Gap(AppGaps.mediumGap),
      BodyIntroductionSections(
        titleTxt: title[0],
        icons: shopData.storeStatus == "Verified"
            ? FontAwesomeIcons.squarePlus
            : null,
        bIsectionFn: () => onBtn(const AddRecycleProductPage()),
      ),
      const Gap(AppGaps.normalGap),
      const ProductSection(),
      const Gap(AppGaps.largeGap),
      BodyIntroductionSections(
        titleTxt: title[1],
        bIsectionFn: () => onBtn(const AddRecycleProductPage()),
      ),
      const Gap(AppGaps.mediumGap),
      Text(
        "Services will be available soon",
        textAlign: TextAlign.center,
        style:
            AppFont.bodyMedium(context).copyWith(color: AppColor.kLightColor),
      ),
    ]);
  }
}
