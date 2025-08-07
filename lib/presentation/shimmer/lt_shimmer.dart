import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';

final apis = FirebaseApi();

class LtShimmer extends StatelessWidget {
  const LtShimmer({super.key, this.isVertical});

  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Stack(
          children: [
            SizedBox(
              width: isVertical != null
                  ? (PhoneSize.deviceWidth(context) / 1)
                  : (PhoneSize.deviceWidth(context) / 2),
              height: 140,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8, top: 5),
                    clipBehavior: Clip.hardEdge,
                    width: isVertical != null
                        ? (PhoneSize.deviceWidth(context) / 1.10)
                        : PhoneSize.deviceWidth(context) / 2.5,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: .10),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(5), right: Radius.circular(40)),
                      child: Container(
                        color: Colors.grey,
                        height: 100,
                        width: PhoneSize.deviceWidth(context) / 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
