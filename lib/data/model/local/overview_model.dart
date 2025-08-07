import 'package:wcycle_bd_store/data/model/local/recycle_info_model.dart';

class OverviewModel {
  const OverviewModel({
    required this.totalOrders,
    required this.totalProducts,
    required this.completedOrders,
    required this.pendingOrders,
    required this.cancelledOrders,
    required this.uniqueCustomers,
    required this.recycleItemInfo,
    required this.completedRecycleItemInfo,
    required this.carbonFootprint,
    required this.completedProducts,
    required this.completedProductsWeight,
    required this.pendingProducts,
    required this.totalPendingProductsWeight,
  });

  final int totalOrders;
  final int totalProducts;
  final int completedOrders;
  final int pendingOrders;
  final int cancelledOrders;
  final int uniqueCustomers;
  final List<RecycleInfoModel> recycleItemInfo;
  final List<RecycleInfoModel> completedRecycleItemInfo;
  final double carbonFootprint;
  final int completedProducts;
  final int completedProductsWeight;
  final int pendingProducts;
  final int totalPendingProductsWeight;
}
