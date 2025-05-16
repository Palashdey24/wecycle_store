import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';

import 'package:wcycle_bd_store/common/widgets/card_container/carousel_card.dart';
import 'package:wcycle_bd_store/common/widgets/card_container/reuseable_container.dart';

class AnnouncementSections extends StatefulWidget {
  const AnnouncementSections({super.key});

  @override
  State<AnnouncementSections> createState() => _AnnouncementSectionsState();
}

class _AnnouncementSectionsState extends State<AnnouncementSections> {
  late PageController _pageController;
  int curentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =
        PageController(initialPage: curentIndex, viewportFraction: 0.75);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 10,
      controller: _pageController,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 0;

            //Below line to check is that page have left or right
            if (_pageController.position.haveDimensions) {
              value = index.toDouble() -
                  (_pageController.page ??
                      0); //if it's the current slide the value will zero
              value = (value * 0.85).clamp(-1, 1);
            }
            return Transform.rotate(
              angle: pi * value,
              child: ReuseableContainer(
                ctColor: Colors.orange.shade500,
                ctMargin: const EdgeInsets.all(22),
                ctWidget: const ReuseableContainer(
                  ctColor: AppColor.kDarkColor,
                  ctMargin: EdgeInsets.only(right: 10),
                  ctWidget: CarouselCard(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
