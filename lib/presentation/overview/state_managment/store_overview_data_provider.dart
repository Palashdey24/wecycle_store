import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/data/model/local/overview_model.dart';
import 'package:wcycle_bd_store/data/model/local/recycle_info_model.dart';
import 'package:wcycle_bd_store/domain/entities/order_data_entities.dart';

class StoreOverviewDataProviderNotifier extends StateNotifier<OverviewModel> {
  StoreOverviewDataProviderNotifier()
      : super(OverviewModel(
            totalOrders: 0,
            totalProducts: 0,
            completedOrders: 0,
            pendingOrders: 0,
            cancelledOrders: 0,
            uniqueCustomers: 0,
            recycleItemInfo: List<RecycleInfoModel>.empty(),
            completedRecycleItemInfo: List<RecycleInfoModel>.empty(),
            completedProducts: 0,
            completedProductsWeight: 0,
            pendingProducts: 0,
            totalPendingProductsWeight: 0,
            carbonFootprint: 0));

  int completeOrder = 0;
  int pendingOrder = 0;
  int cancelledOrder = 0;
  int totalOrders = 0;
  int totalProducts = 0;
  List<RecycleInfoModel> pendingOrderItemInfo = [];
  List<RecycleInfoModel> completedOrderItemInfo = [];
  int completedProducts = 0;
  double completedProductWeight = 0.0;
  int pendingProducts = 0;
  int totalPendingProductsWeight = 0;
  List<String> uniqueCustomerLists = [];

  Future<void> getOverviewData(List<OrderDataEntity> shopData) async {
    totalOrders = shopData.length;

    completeOrder = 0;
    pendingOrder = 0;
    cancelledOrder = 0;
    totalOrders = 0;
    totalProducts = 0;
    pendingOrderItemInfo = [];
    completedOrderItemInfo = [];
    completedProducts = 0;
    completedProductWeight = 0.0;
    pendingProducts = 0;
    totalPendingProductsWeight = 0;
    uniqueCustomerLists = [];

    for (var data in shopData) {
      totalProducts += data.products!.length;

      if (data.status != null && data.products != null) {
        getOrderStatusWithItemInfo(data.status!, data.products!);
      }

      getUniqueCustomers(data.address);
    }

    /*for (var data in shopData) {


      if (!uniqueCustomerLists.contains(data.address.userId)) {
        uniqueCustomerLists.add(data.address.userId);
      }

      // * This For getting total recycle item info and completed recycle item info

      // * End Here For Loop

      if (data.status![data.status!.length - 1].status == "Completed") {
        completeOrder++;

        for (var product in data.products!) {
          completedProducts++;
          completedProductWeight += product.quantity;

          if (completedRecycleItemInfo.isEmpty) {
            for (int i = 0; i < completedRecycleItemInfo.length; i++) {
              if (completedRecycleItemInfo[i].recycleItemName ==
                  product.productName) {
                completedRecycleItemInfo[i].weight += product.quantity;
              } else {
                completedRecycleItemInfo.add(RecycleInfoModel(
                    recycleItemName: product.productName,
                    weight: product.quantity.toDouble()));
              }
            }
          } else {
            completedRecycleItemInfo.add(RecycleInfoModel(
                recycleItemName: product.productName,
                weight: product.quantity.toDouble()));
          }
        }
      } else if (data.status![data.status!.length - 1].status == "Cancelled") {
        cancelledOrder++;
      } else {
        pendingOrder++;

        for (var product in data.products!) {
          pendingProducts++;
          totalPendingProductsWeight += product.quantity;

          if (recycleItemInfo.isEmpty) {
            for (int i = 0; i < recycleItemInfo.length; i++) {
              if (recycleItemInfo[i].recycleItemName == product.productName) {
                recycleItemInfo[i].weight += product.quantity;
              } else {
                recycleItemInfo.add(RecycleInfoModel(
                    recycleItemName: product.productName,
                    weight: product.quantity.toDouble()));
              }
            }
          } else {
            recycleItemInfo.add(RecycleInfoModel(
                recycleItemName: product.productName,
                weight: product.quantity.toDouble()));
          }
        }
      }
    }*/

    // * For getting completed order info
    //getItemInfo(shopData, completedRecycleItemInfo);

    final overview = OverviewModel(
        totalOrders: totalOrders,
        totalProducts: totalProducts,
        completedOrders: completeOrder,
        pendingOrders: pendingOrder,
        cancelledOrders: cancelledOrder,
        uniqueCustomers: uniqueCustomerLists.length,
        recycleItemInfo: pendingOrderItemInfo,
        completedRecycleItemInfo: completedOrderItemInfo,
        completedProducts: completedProducts,
        completedProductsWeight: completedProductWeight.toInt(),
        totalPendingProductsWeight: totalPendingProductsWeight,
        pendingProducts: pendingProducts,
        carbonFootprint: 0);
    state = overview;
  }

  void getOrderStatusWithItemInfo(
      List<Status> status, List<Products> products) {
    if (status[status.length - 1].status == "Completed") {
      completeOrder++;
      for (var product in products) {
        completedProducts++;
        completedProductWeight += product.quantity;
        getCompletItemInfo(product);
      }
      return;
    } else if (status[status.length - 1].status == "Cancelled") {
      cancelledOrder++;
      return;
    } else {
      pendingOrder++;
      for (var product in products) {
        pendingProducts++;
        totalPendingProductsWeight += product.quantity;
        getPendingItemInfo(product);
      }
      return;
    }
  }

  void getCompletItemInfo(Products product) {
    if (completedOrderItemInfo.isEmpty) {
      for (int i = 0; i < completedOrderItemInfo.length; i++) {
        if (completedOrderItemInfo[i].recycleItemName == product.productName) {
          completedOrderItemInfo[i].weight += product.quantity;
        } else {
          completedOrderItemInfo.add(RecycleInfoModel(
              recycleItemName: product.productName,
              weight: product.quantity.toDouble()));
        }
      }
    } else {
      completedOrderItemInfo.add(RecycleInfoModel(
          recycleItemName: product.productName,
          weight: product.quantity.toDouble()));
    }
  }

  void getPendingItemInfo(Products product) {
    if (pendingOrderItemInfo.isEmpty) {
      for (int i = 0; i < pendingOrderItemInfo.length; i++) {
        if (pendingOrderItemInfo[i].recycleItemName == product.productName) {
          pendingOrderItemInfo[i].weight += product.quantity;
        } else {
          pendingOrderItemInfo.add(RecycleInfoModel(
              recycleItemName: product.productName,
              weight: product.quantity.toDouble()));
        }
      }
    } else {
      pendingOrderItemInfo.add(RecycleInfoModel(
          recycleItemName: product.productName,
          weight: product.quantity.toDouble()));
    }
  }

  void getCarbonFootprint(List<RecycleInfoModel> recycleItemInfo) {}

  void getUniqueCustomers(Address address) {
    if (!uniqueCustomerLists.contains(address.userId)) {
      uniqueCustomerLists.add(address.userId);
    }
  }
}

final storeOverviewDataProvider =
    StateNotifierProvider<StoreOverviewDataProviderNotifier, OverviewModel>(
        (ref) {
  return StoreOverviewDataProviderNotifier();
});
