import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/common/riverpod/indiviual_store_info_provider.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';
import 'package:wcycle_bd_store/domain/entities/order_data_entities.dart';
import 'package:wcycle_bd_store/domain/entities/store_data_entities.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/page_frame.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/page_header.dart';
import 'package:wcycle_bd_store/presentation/order/widgets/address_locations_ui.dart';
import 'package:wcycle_bd_store/presentation/setting/widgets/store_profile_data_ui.dart';

import '../../../core/config/theme/gap.dart' as AppGaps;

class SettingPages extends ConsumerWidget {
  const SettingPages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeInfo = ref.watch(individualStoreProvider);

    final StoreDataEntity(
      :logoUri,
      :storeName,
      :storeStatus,
      :email,
      :phoneNumber,
      :storeAddress,
      :locations
    ) = storeInfo;

    List<Map<String, String>> profileData = [
      {"Data": email, "Title": "Email"},
      {"Data": phoneNumber, "Title": "Phone Number"},
      {"Data": storeAddress, "Title": "Address"},
    ];
    return PageFrame(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
        pageWidgets: [
          const PageHeader(pageName: "Setting"),
          const Gap(largeGap),
          SizedBox(
            height: PhoneSize.deviceHeight(context) - (largeGap * 8),
            child: ListView(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0), //or 15.0
                  child: Container(
                    height: 150.0,
                    width: 70.0,
                    color: Colors.white,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder:
                          const AssetImage("assets/welcome-stores.png"),
                      image: NetworkImage(
                        logoUri,
                      ),
                    ),
                  ),
                ),
                const Gap(normalGap),
                Text(
                  storeName,
                  textAlign: TextAlign.center,
                  style:
                      AppFont.bodyMedium(context).copyWith(color: Colors.white),
                ),
                const Gap(normalGap),
                Text(
                  storeStatus,
                  textAlign: TextAlign.center,
                  style: AppFont.bodySmall(context)
                      .copyWith(color: AppColor.kLightColor),
                ),
                const Gap(mediumGap),
                const Divider(
                  color: Colors.white,
                ),
                Card(
                    margin: const EdgeInsetsGeometry.all(5),
                    color: AppColor.kSecondColor,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        for (var data in profileData)
                          StoreProfileDataUi(
                              data: data["Data"]!, title: data["Title"]!),
                      ],
                    )),
                const Gap(largeGap),
                Card(
                  margin: const EdgeInsetsGeometry.all(5),
                  color: AppColor.kSecondColor,
                  child: AddressLocationsUi(
                    takeLocationsData: (address, lat, long) {},
                    addressModel: Address(
                        zip: "zip",
                        isDefault: false,
                        apt: "apt",
                        city: "city",
                        street: "street",
                        contactNumber: "contactNumber",
                        name: "",
                        userId: "userId",
                        long: locations.lon,
                        lat: locations.lat,
                        mapAddress: locations.address),
                  ),
                ),
                const Gap(AppGaps.largeGap),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Deleted Account"))
              ],
            ),
          ),
        ]);
  }
}
