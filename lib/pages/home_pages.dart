import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/dimensions/app_gaps.dart';
import 'package:wcycle_bd_store/common/helper/navigator/app_navigator.dart';

import 'package:wcycle_bd_store/presentation/add_data/pages/add_recycle_product_page.dart';
import 'package:wcycle_bd_store/screen/ui_view/home_screen/home_page/announcement_sections.dart';
import 'package:wcycle_bd_store/screen/ui_view/home_screen/home_page/body_introduction_sections.dart';
import 'package:wcycle_bd_store/screen/ui_view/home_screen/home_page/product_section.dart';
import 'package:wcycle_bd_store/widgets/page_header.dart';

import 'package:wcycle_bd_store/core/config/theme/gap.dart';

import 'package:wcycle_bd_store/widgets/page_frame.dart';

const List<String> title = ["Announcement", "Product", "Services"];

final apis = FirebaseApi();

class HomePages extends ConsumerWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onBtn(Widget navWidget) {
      AppNavigatior.navigatorPushWithTransition(
          context, navWidget, const Offset(0, -1), Curves.easeInSine);
    }

    return PageFrame(pageWidgets: [
      const PageHeader(pageName: "Home"),
      const Gap(largeGap),
      BodyIntroductionSections(titleTxt: title[0]),
      const SizedBox(height: 200, child: AnnouncementSections()),
      const Gap(10),
      BodyIntroductionSections(
        titleTxt: title[1],
        icons: FontAwesomeIcons.squarePlus,
        bIsectionFn: () => onBtn(const AddRecycleProductPage()),
      ),
      const Gap(AppGaps.normalGap),
      const ProductSection(),
      const Gap(AppGaps.normalGap),
      BodyIntroductionSections(
        titleTxt: title[2],
        icons: FontAwesomeIcons.squarePlus,
        bIsectionFn: () => onBtn(const AddRecycleProductPage()),
      ),
      const Gap(AppGaps.normalGap),
    ]);
  }
}
