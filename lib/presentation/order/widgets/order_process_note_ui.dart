import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/helper/dialog_loading/dialogs_helper.dart';
import 'package:wcycle_bd_store/common/widgets/card_container/card_for_form.dart';
import 'package:wcycle_bd_store/common/widgets/fields/form_simple_texts.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/utility/string/app_string.dart';
import 'package:wcycle_bd_store/domain/entities/order_data_entities.dart';

class OrderProcessNoteUi extends StatelessWidget {
  const OrderProcessNoteUi(
      {super.key,
      required this.stepName,
      required this.orderID,
      required this.address});

  final String stepName;
  final String orderID;
  final Address address;

  static String? commonValidator(String? value, String? errorMsg) {
    if (value == null || value.trim().isEmpty || value.trim().length < 3) {
      return errorMsg;
    }
    return null;
  }

  static String? phoneValidator(String? value, String? errorMsg) {
    if (value == null || value.trim().isEmpty || value.trim().length < 14) {
      return errorMsg;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    String? pickerName;
    String? pickerNumber;
    String? payAmount;

    String getNote(String status) {
      if (status == "Out to take") {
        return "Pickup assign $pickerName. Contact: $pickerNumber";
      } else if (status == "To Pay") {
        return "Amount will be paid by Cash to ${address.name}. Total amount is $payAmount";
      }

      return "";
    }

    void onUpdateStep() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        final fsRef =
            FirebaseApi().fireStore.collection("recycleOrder").doc(orderID);
        DialogsLoading.showProgressBar(context);

        fsRef.update(
          {
            "status": FieldValue.arrayUnion([
              {
                "status": stepName,
                "Time": AppString().formatedOrderDate(DateTime.now()),
                "note": getNote(stepName)
              }
            ])
          },
        ).whenComplete(
          () {
            if (!context.mounted) return;
            Navigator.of(context)
              ..pop()
              ..pop();
            DialogsLoading.showMessage(context, "Step Updated");
          },
        ).onError(
          (error, stackTrace) {
            if (!context.mounted) return;
            Navigator.of(context)
              ..pop()
              ..pop();
            DialogsLoading.showMessage(context, error.toString());
          },
        );
      }
    }

    return Form(
        key: formKey,
        child: CardForForm(cardWidgets: [
          if (stepName == "Out to take")
            FormSimpleTexts(
              labelTxt: "Picker Name*",
              hint: "Pickup Person Name",
              txtInType: TextInputType.text,
              validator: (value) =>
                  commonValidator(value, "Picker Name is required"),
              onSave: (String value) {
                pickerName = value;
              },
            ),
          if (stepName == "Out to take")
            FormSimpleTexts(
              labelTxt: "Picker contact*",
              hint: "Pickup Person contact Number",
              intial: "+880",
              maxLen: 14,
              txtInType: TextInputType.phone,
              validator: (value) =>
                  phoneValidator(value, "Picker Number is required"),
              onSave: (String value) {
                pickerNumber = value;
              },
            ),
          if (stepName == "To Pay")
            FormSimpleTexts(
              labelTxt: "Amount*",
              hint: "Amount to Pay",
              txtInType: TextInputType.number,
              validator: (value) =>
                  commonValidator(value, "Amount should be Like 10.00"),
              onSave: (String value) {
                payAmount = value;
              },
            ),
          Row(children: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                style:
                    TextButton.styleFrom(backgroundColor: AppColor.kDarkColor),
                child: const Text("Cancel",
                    style: TextStyle(color: Colors.white))),
            const Spacer(),
            TextButton(
              onPressed: () => onUpdateStep(),
              style: TextButton.styleFrom(backgroundColor: AppColor.kDarkColor),
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ], title: stepName));
  }
}
