import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/widgets/recycle_list_item.dart';

class RecycleShimmer extends StatelessWidget {
  const RecycleShimmer({super.key, this.isVertical});

  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: AppColor.kLightColor,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (int a = 1; a <= 5; a++) const RecycleListItem(),
          ],
        ));
  }
}
