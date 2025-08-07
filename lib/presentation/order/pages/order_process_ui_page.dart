import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/dimensions/app_gaps.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/common/helper/dialog_loading/dialogs_helper.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/utility/string/app_string.dart';
import 'package:wcycle_bd_store/domain/entities/order_data_entities.dart';
import 'package:wcycle_bd_store/presentation/order/state_managment/indiviual_order_provider.dart';
import 'package:wcycle_bd_store/presentation/order/widgets/order_delivery_info_ui.dart';
import 'package:wcycle_bd_store/presentation/order/widgets/order_item_essential_info_ui.dart';
import 'package:wcycle_bd_store/presentation/order/widgets/order_process_note_ui.dart';

class OrderProcessUiPage extends ConsumerWidget {
  const OrderProcessUiPage({
    super.key,
    required this.currentProcessIndex,
    required this.nextOrFinalStep,
  });

  final int currentProcessIndex;
  final String nextOrFinalStep;

  static const List<String> processOptions = <String>[
    'Placed',
    'Processing',
    'Out to take',
    'To Pay',
    'Paid',
    'Completed',
    'Cancelled',
  ];

  static String getNote(String status) {
    if (status == "Processing") {
      return "Order are accept by store";
    } else if (status == "Paid") {
      return "Order is paid";
    } else if (status == "Completed") {
      return "Order is completed";
    } else if (status == "Cancelled") {
      return "Order is cancelled";
    }

    return "";
  }

  static void stepAboutDialog(BuildContext context,
      {required String selectedValue,
      required String orderID,
      required Address address}) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
            width: PhoneSize.deviceWidth(context) * 0.9,
            height: PhoneSize.deviceHeight(context) * 0.65,
            child: OrderProcessNoteUi(
              stepName: selectedValue,
              address: address,
              orderID: orderID,
            )),
      ),
    );
  }

  static void updatedStep(BuildContext context,
      {required String orderID,
      required String status,
      required String note,
      required WidgetRef ref}) {
    final fsRef =
        FirebaseApi().fireStore.collection("recycleOrder").doc(orderID);
    DialogsLoading.showProgressBar(context);

    fsRef.update(
      {
        "status": FieldValue.arrayUnion([
          {
            "status": status,
            "Time": AppString().formatedOrderDate(DateTime.now()),
            "note": note
          }
        ])
      },
    ).whenComplete(
      () {
        if (!context.mounted) return;
        ref.read(individualOrderProvider.notifier).getOrder(orderID);
        Navigator.of(context)
          ..pop()
          ..pop();
        DialogsLoading.showMessage(context, "Step Updated");
      },
    ).onError(
      (error, stackTrace) {
        if (!context.mounted) return;
        Navigator.pop(context);
        DialogsLoading.showMessage(context, error.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<String> selectedValue =
        ValueNotifier<String>(nextOrFinalStep);

    final order = ref.watch(individualOrderProvider);

    List<DropdownMenuItem> processItems = [];

    if (currentProcessIndex < processOptions.length) {
      int processIndex;

      // * If Else statement for checking processOption length validation
      if (currentProcessIndex == 0) {
        processIndex = processOptions.length;
      } else {
        processIndex = processOptions.length - 1;
      }
      /* * This below for Make dropdown menu item after current Process Steps */

      for (var i = currentProcessIndex + 1; i < processIndex; i++) {
        processItems.add(DropdownMenuItem(
          value: processOptions[i],
          child: Text(processOptions[i]),
        ));
      }
    }

    Future<void> saveBtn(String value) async {
      if (value == "Out to take" || value == "To Pay") {
        Navigator.pop(context);
        stepAboutDialog(context,
            orderID: order.orderID!,
            selectedValue: selectedValue.value,
            address: order.address);
        return;
      }

      updatedStep(context,
          orderID: order.orderID!,
          status: value,
          note: getNote(selectedValue.value),
          ref: ref);
    }

    void dropDownVaildation(String value) {
      if (value == "Cancelled") {
        saveBtn(value);
        return;
      } else if (value == processOptions[currentProcessIndex + 1]) {
        saveBtn(value);
        return;
      }
      DialogsLoading.showMessage(
          context, "Invalid Step. Please follow the Step order");
      return;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Process",
          style: AppFont.bodyMedium(context)
              .copyWith(color: Colors.deepOrangeAccent),
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: AppGaps.normalGap),
          children: [
            Card(
                child: OrderItemEssentialInfoUi(
              order: order,
              deliveryInfo: [
                OrderDeliveryInfoUi(
                    uiTittle: "Total Payable:",
                    uiData: order.totalPrice.toString()),
              ],
            )),
            const Gap(AppGaps.largeGap),
            Text(
              "Steps",
              style: AppFont.bodyLarge(context)
                  .copyWith(color: AppColor.kLightColor),
            ),
            const Gap(AppGaps.mediumGap),
            for (final step in order.status!)
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(
                    horizontal: AppGaps.normalGap, vertical: AppGaps.mediumGap),
                child: Flex(
                  direction: Axis.vertical,
                  spacing: AppGaps.normalGap,
                  children: [
                    Row(
                      children: [
                        Text(
                          step.status,
                          style: AppFont.bodyMedium(context)
                              .copyWith(color: AppColor.kLightColor),
                        ),
                        const Spacer(),
                        Text(
                          step.Time,
                          style: AppFont.bodyMedium(context)
                              .copyWith(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    Text(
                      "Note: ${step.note ?? "Order has been Placed by ${order.address.name}"}",
                      style: const TextStyle(color: Colors.amber),
                    )
                  ],
                ),
              ),
            if (order.status![order.status!.length - 1].status != "Cancelled" &&
                order.status![order.status!.length - 1].status != "Completed")
              Flex(
                direction: Axis.vertical,
                spacing: AppGaps.mediumGap,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder(
                        valueListenable: selectedValue,
                        builder: (context, value, child) {
                          return DropdownButtonFormField(
                            value: selectedValue.value,
                            hint: Text(
                              order.status![0].status,
                              style: const TextStyle(color: Colors.white),
                            ),
                            style: const TextStyle(color: Colors.orangeAccent),
                            //this line for DropDown Dialog background color or Radius
                            dropdownColor: Colors.black,
                            borderRadius: BorderRadius.circular(30),

                            //Decoration refer for hint and other outer
                            decoration: InputDecoration(
                                label: const Text(
                                  "Process",
                                  style: TextStyle(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            items: processItems,
                            onChanged: (value) {
                              selectedValue.value = value!;
                            },
                          );
                        }),
                  ),
                  ElevatedButton(
                      onPressed: () => dropDownVaildation(selectedValue.value),
                      child: const Text("Update Step")),
                  const Gap(AppGaps.largeGap),
                ],
              ),
            if (order.status![order.status!.length - 1].status == "Cancelled" &&
                order.status![order.status!.length - 1].status == "Completed")
              ElevatedButton(onPressed: () {}, child: const Text("Done"))
          ]),
    );
  }
}
