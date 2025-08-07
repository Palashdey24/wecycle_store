import 'dart:io';

import 'package:wcycle_bd_store/data/model/local/store_location_model.dart';

class StoreInformationEntities {
  StoreInformationEntities({
    required this.storeName,
    required this.emailAddress,
    required this.password,
    required this.phoneNumber,
    required this.binNumber,
    required this.storeAddress,
    required this.logoName,
    required this.docName,
    required this.locationAddress,
    required this.storeLocationModel,
    required this.logoPath,
    required this.docPath,
  });

  final String emailAddress;
  final String password;
  final String storeName;
  final String phoneNumber;
  final String binNumber;
  final String storeAddress;
  final String logoName;
  final String docName;
  final File logoPath;
  final File docPath;
  final String locationAddress;
  final StoreLocationModel storeLocationModel;
}
