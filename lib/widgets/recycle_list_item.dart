import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd_store/widgets/recycle_list_item_info.dart';

class RecycleListItem extends ConsumerWidget {
  const RecycleListItem({
    super.key,
    this.rcListModel,
    this.isDtPage,
  });

  final RecycleProductModel? rcListModel;
  final bool? isDtPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 140,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              InkWell(
                onTap: () {
/*                  rcProviderFn.shopProduct(rcListModel);
                  if (!isDtPage) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecycableProductDetails(),
                        ));
                  }*/
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10, top: 20),
                  width: 100,
                  height: 120,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColor.kSecondColor,
                      AppColor.kLightColor,
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: rcListModel != null
                      ? RecycleListItemInfo(rcListModel: rcListModel!)
                      : null,
                ),
              ),
              Positioned(
                  top: 0,
                  left: 10,
                  child: Transform.rotate(
                    angle: -0.35,
                    child: CircleAvatar(
                      backgroundColor: rcListModel != null
                          ? Colors.transparent
                          : Colors.white,
                      radius: 29,
                      child: rcListModel != null
                          ? FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: NetworkImage(rcListModel!.productImage))
                          : null,
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
