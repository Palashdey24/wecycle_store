import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/dimensions/app_gaps.dart';
import 'package:wcycle_bd_store/common/helper/dialog_loading/dialogs_helper.dart';
import 'package:wcycle_bd_store/common/helper/navigator/app_navigator.dart';
import 'package:wcycle_bd_store/common/widgets/fields/field_text.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/data/model/local/store_location_model.dart';
import 'package:wcycle_bd_store/presentation/auth/pages/auth_state_page.dart';
import 'package:wcycle_bd_store/presentation/auth/widgets/store_info/final_step.dart';
import 'package:wcycle_bd_store/presentation/auth/widgets/store_info/locations_input.dart';
import 'package:wcycle_bd_store/presentation/auth/widgets/store_info/stepper_field_frame.dart';
import 'package:wcycle_bd_store/presentation/auth/widgets/store_info/upload_file.dart';

final fsApis = FirebaseApi();

class StepperInfo extends StatefulWidget {
  const StepperInfo(
      {super.key, required this.emailAddress, required this.password});
  final String emailAddress;
  final String password;

  @override
  State<StepperInfo> createState() => _StepperInfoState();
}

class _StepperInfoState extends State<StepperInfo> {
  String? _storeName;
  String? _storeBin;
  String? _storeNumber;
  int _activeStepIndex = 0;
  File? docFile;
  File? logoFile;
  String? docFileName;
  String? logoFileName;
  StoreLocationModel? storeLocation;
  String? _storeAddress;
  late String userId;

  Map<String, dynamic>? _sInfoEntity;

  void addData() async {
    DialogsLoading.showProgressBar(context, waitingMsg: "Upload Progress....");
    try {
      userId = fsApis.currentUser.uid;
      final uploadDoc = await fsApis.uploadFile(
          context, "Store", "pdf", docFileName!, docFile!, false);

      if (!mounted) return;
      final uploadLogo = await fsApis.uploadFile(
          context, "Store", "image", logoFileName!, logoFile!, false);

      if (uploadLogo != null || uploadDoc != null) {
        if (!mounted) return;
        fsApis.setUser({
          "id": fsApis.currentUser.uid,
          "storeName": _storeName,
          "email": widget.emailAddress,
          "phoneNumber": _storeNumber,
          "storeBin": _storeBin,
          "storeAddress": _storeAddress,
          "logoUri": uploadLogo,
          "docUri": uploadDoc,
          "locations": {
            "lat": storeLocation!.lat,
            "lon": storeLocation!.lon,
            "address": storeLocation!.address
          },
          "storeStatus": "Under Review",
        }, "store", context);
        Navigator.pop(context);
        AppNavigatior.navigatorPushAndRemove(context, const AuthStatePages());
      }
    } on FirebaseException catch (error) {
      if (!mounted) return;
      Navigator.pop(context);
      DialogsLoading.removeMessage(context);
      DialogsLoading.showMessage(
          context, error.message ?? "Authentication Failed");
    }
  }

  void onContinue() {
    switch (_activeStepIndex) {
      case 0:
        {
          if (_storeName == null ||
              _storeName!.trim().isEmpty ||
              _storeBin == null ||
              _storeBin!.trim().isEmpty ||
              _storeNumber == null ||
              _storeNumber!.trim().isEmpty ||
              _storeNumber!.length < 11) {
            DialogsLoading.removeMessage(context);
            DialogsLoading.showMessage(context,
                "Please check you added Name, Bin and 11 number Phone number");
            return;
          }
          setState(() {
            _activeStepIndex += 1;
          });
        }
        break;
      case 1:
        {
          if (logoFile == null || docFile == null) {
            DialogsLoading.removeMessage(context);
            DialogsLoading.showMessage(
                context, "Please check to added Logo and Store Document");
            return;
          }
          setState(() {
            _activeStepIndex += 1;
          });
        }
        break;
      case 2:
        {
          if (_storeAddress == null ||
              _storeAddress!.trim().isEmpty ||
              storeLocation == null) {
            DialogsLoading.removeMessage(context);
            DialogsLoading.showMessage(
                context, "Please check to added address and Store Location");
            return;
          }

          setState(() {
            _sInfoEntity = {
              "emailAddress": "email",
              "password": "password",
              "storeName": _storeName!,
              "phoneNumber": _storeNumber!,
              "binNumber": _storeBin!,
              "storeAddress": _storeAddress!,
              "docName": docFileName!,
              "docPath": docFile!,
              "locationAddress": _storeAddress!,
              "logoName": logoFileName!,
              "logoPath": logoFile!,
              "storeLocationModel": storeLocation,
            };
            _activeStepIndex += 1;
          });
        }
        break;
      case 3:
        {
          addData();
        }
        break;
    }
  }

  void onCancel() {
    if (_activeStepIndex == 0) {
      return;
    }
    setState(() {
      _activeStepIndex -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controller: ScrollController(),
      type: StepperType.horizontal,
      currentStep: _activeStepIndex,
      physics: const ScrollPhysics(),
      steps: [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: Text(
              "info",
              style: AppFont.bodySmall(context),
            ),
            content: Column(
              children: [
                StepperFieldFrame(
                    steperFieldText: "Store Name",
                    fieldWidget: FieldTexts(
                        fieldFn: (fieldValue) {
                          _storeName = fieldValue;
                        },
                        txtInType: TextInputType.text,
                        hint: "Add Store Name",
                        icons: FontAwesomeIcons.store,
                        iconCol: AppColor.kDarkColor)),
                StepperFieldFrame(
                    steperFieldText: "Bin Number",
                    fieldWidget: FieldTexts(
                        fieldFn: (fieldValue) {
                          _storeBin = fieldValue;
                        },
                        txtInType: TextInputType.number,
                        hint: "Add Bin Number",
                        icons: FontAwesomeIcons.barcode,
                        iconCol: AppColor.kDarkColor)),
                StepperFieldFrame(
                    steperFieldText: "PhoneNumber",
                    fieldWidget: FieldTexts(
                        fieldFn: (fieldValue) {
                          _storeNumber = fieldValue;
                        },
                        txtInType: TextInputType.number,
                        maxLen: 11,
                        hint: "Add Phone Number",
                        icons: FontAwesomeIcons.squarePhoneFlip,
                        iconCol: AppColor.kDarkColor)),
              ],
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: Text(
              "Document",
              style: AppFont.bodySmall(context),
            ),
            content: Column(
              children: [
                UploadFile(
                  btnTittle: "Upload Logo",
                  fileExtension: const ["jpg", "png"],
                  elvationIcons: FontAwesomeIcons.fileImage,
                  getPath: (filePath, downloadLink) {
                    logoFile = filePath;
                    logoFileName = downloadLink;
                  },
                ),
                const Gap(AppGaps.mediumGap),
                UploadFile(
                  btnTittle: "Upload Doc",
                  fileExtension: const ["pdf"],
                  elvationIcons: FontAwesomeIcons.filePdf,
                  getPath: (filePath, downloadLink) {
                    docFile = filePath;
                    docFileName = downloadLink;
                  },
                ),
              ],
            )),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: Text(
              "Address",
              style: AppFont.bodySmall(context),
            ),
            content: Column(
              children: [
                StepperFieldFrame(
                    steperFieldText: "Full Address",
                    fieldWidget: FieldTexts(
                        fieldFn: (fieldValue) {
                          _storeAddress = fieldValue;
                        },
                        txtInType: TextInputType.text,
                        hint: "Address,City,Thana,Division",
                        icons: FontAwesomeIcons.solidAddressCard,
                        iconCol: AppColor.kDarkColor)),
                const Gap(AppGaps.largeGap),
                LocationsInput(
                  storeLocationFn: (stLocModel) => storeLocation = stLocModel,
                ),
              ],
            )),
        Step(
          title: Text(
            "Complete",
            style: AppFont.bodySmall(context),
          ),
          content: FinalStep(sEntity: _sInfoEntity ?? {}),
        ),
      ],
      onStepContinue: onContinue,
      onStepCancel: onCancel,
    );
  }
}
