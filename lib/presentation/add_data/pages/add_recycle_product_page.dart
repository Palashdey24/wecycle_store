import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/helper/dialog_loading/dialogs_helper.dart';
import 'package:wcycle_bd_store/common/widgets/btn/back_btn.dart';
import 'package:wcycle_bd_store/common/widgets/fields/field_text.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/common/dimensions/app_gaps.dart';
import 'package:wcycle_bd_store/presentation/add_data/widgets/recycle_firebase_data.dart';
import 'package:wcycle_bd_store/widgets/page_header.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';
import 'package:wcycle_bd_store/widgets/page_frame.dart';

final firebaseHelper = FirebaseApi();

class AddRecycleProductPage extends StatelessWidget {
  const AddRecycleProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? productName;

    String impactLevel = "N/A";

    String? productUri;
    double? productprice;

    void onAdd() async {
      DialogsLoading.showProgressBar(context);
      if (productName == null || productUri == null || productprice == null) {
        Navigator.pop(context);
        DialogsLoading.removeMessage(context);
        DialogsLoading.showMessage(
            context, "Please check to add Product Price and Product Name");
        return;
      } else {
        Navigator.pop(context);
        await firebaseHelper.upFirestoreData({
          "productName": productName,

          "productImage": productUri,
          "impactLevel": impactLevel,
          "productPrice": productprice,
          "productOnline": false,
          "shopID": FirebaseAuth.instance.currentUser!.uid
          // "ProductOnline": true,
        }, "recycleProduct", context).then(
          (value) {
            if (!context.mounted) return;
            if (value == null || value.isEmpty) {
              DialogsLoading.removeMessage(context);
              DialogsLoading.showMessage(context, "Failed added");
              return;
            }
            Navigator.pop(context);
          },
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageFrame(pageWidgets: [
              const PageHeader(pageName: "Add Product"),
              const Gap(largeGap),
              RecycleFirebaseData(
                onLoadFn: (proName, proImpact, proUri) {
                  productName = proName;
                  impactLevel = proImpact;
                  productUri = proUri;
                },
              ),
              const Gap(AppGaps.normalGap),
              FieldTexts(
                paddingHorizential: AppGaps.normalGap,
                txtInType: const TextInputType.numberWithOptions(decimal: true),
                hint: "Price",
                icons: FontAwesomeIcons.sackDollar,
                iconCol: AppColor.kSecondColor,
                fieldFn: (fieldValue) {
                  productprice = double.tryParse(fieldValue);
                },
              ),
              const Gap(AppGaps.largeGap),
              ElevatedButton(
                onFocusChange: (value) => FocusScope.of(context).unfocus(),
                onPressed: onAdd,
                child: const Text("Add"),
              )
            ]),
            const Positioned(top: mediumGap, child: BackBtn()),
          ],
        ),
      ),
    );
  }
}
