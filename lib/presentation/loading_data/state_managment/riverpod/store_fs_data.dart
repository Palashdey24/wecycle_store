import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/domain/entities/store_data_entities.dart';

class StoreFsDataProviderNotifier extends StateNotifier<List<StoreDataEntity>> {
  StoreFsDataProviderNotifier() : super([]);

  Future<bool?> loadStoreAllData() async {
    final fsRef = await FirebaseFirestore.instance.collection('store').get();
    final storeData = fsRef.docs;

    final storeDataList =
        storeData.map((e) => StoreDataEntity.fromJson(e.data())).toList();

    state = storeDataList;
    return true;
  }
}

final storeFsDataProvider =
    StateNotifierProvider<StoreFsDataProviderNotifier, List<StoreDataEntity>>(
        (ref) {
  return StoreFsDataProviderNotifier();
});
