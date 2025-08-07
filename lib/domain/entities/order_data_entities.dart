class OrderDataEntity {
  OrderDataEntity({
    this.metaDatas,
    required this.address,
    required this.totalPrice,
    required this.storeId,
    this.status,
    this.products,
  });
  //final List<MetaData>? metaData;
  late final Address address;
  late final double totalPrice;
  late final String storeId;
  List<Status>? status;
  List<Products>? products;
  List<MetaData>? metaDatas;
  String? orderID;

  OrderDataEntity.fromJson(Map<String, dynamic> json, {this.orderID}) {
    metaDatas =
        List.from(json['metaData']).map((e) => MetaData.fromJson(e)).toList();
    address = Address.fromJson(json['address']);
    totalPrice = json['totalPrice'];
    storeId = json['storeId'];
    status = List.from(json['status']).map((e) => Status.fromJson(e)).toList();
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // _data['metaData'] = metaData?.map((e) => e.toJson()).toList() ?? [];
    data['address'] = address.toJson();
    data['totalPrice'] = totalPrice;
    data['storeId'] = storeId;
    // _data['status'] = status?.map((e) => e.toJson()).toList() ?? [];
    // _data['products'] = products?.map((e) => e.toJson()).toList() ?? [];
    return data;
  }
}

class MetaData {
  MetaData({
    required this.metaName,
    required this.metaData,
  });
  late final String metaName;
  late final String metaData;

  MetaData.fromJson(Map<String, dynamic> json) {
    metaData = json['metaData'];
    metaName = json['metaName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['metaData'] = metaData;
    data['metaName'] = metaName;
    return data;
  }
}

class Address {
  Address({
    required this.zip,
    required this.isDefault,
    required this.apt,
    required this.city,
    required this.street,
    required this.contactNumber,
    required this.name,
    required this.userId,
    required this.long,
    required this.lat,
    required this.mapAddress,
  });
  late final String zip;
  late final bool isDefault;
  late final String apt;
  late final String city;
  late final String street;
  late final String contactNumber;
  late final String name;
  late final String userId;
  late final double long;
  late final double lat;
  late final String mapAddress;

  Address.fromJson(Map<String, dynamic> json) {
    zip = json['zip'];
    isDefault = json['isDefault'];
    apt = json['apt'];
    city = json['city'];
    street = json['street'];
    contactNumber = json['contactNumber'];
    name = json['name'];
    userId = json['userId'];
    long = json['long'];
    lat = json['lat'];
    mapAddress = json['mapAddress'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['zip'] = zip;
    data['isDefault'] = isDefault;
    data['apt'] = apt;
    data['city'] = city;
    data['street'] = street;
    data['contactNumber'] = contactNumber;
    data['name'] = name;
    data['userId'] = userId;
    data['long'] = long;
    data['lat'] = lat;
    data['mapAddress'] = mapAddress;
    return data;
  }
}

class Status {
  Status({
    required this.Time,
    required this.status,
    this.note,
  });
  late final String Time;
  late final String status;
  late final String? note;

  Status.fromJson(Map<String, dynamic> json) {
    Time = json['Time'];
    status = json['status'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Time'] = Time;
    data['status'] = status;
    data['note'] = note;
    return data;
  }
}

class Products {
  Products({
    required this.impactLevel,
    required this.quantity,
    required this.productImage,
    required this.productID,
    required this.productOnline,
    required this.shopID,
    required this.productName,
    required this.productPrice,
  });
  late final String impactLevel;
  late final int quantity;
  late final String productImage;
  late final String productID;
  late final bool productOnline;
  late final String shopID;
  late final String productName;
  late final double productPrice;

  Products.fromJson(Map<String, dynamic> json) {
    impactLevel = json['impactLevel'];
    quantity = json['quantity'];
    productImage = json['productImage'];
    productID = json['productID'];
    productOnline = json['productOnline'];
    shopID = json['shopID'];
    productName = json['productName'];
    productPrice = json['productPrice'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['impactLevel'] = impactLevel;
    data['quantity'] = quantity;
    data['productImage'] = productImage;
    data['productID'] = productID;
    data['productOnline'] = productOnline;
    data['shopID'] = shopID;
    data['productName'] = productName;
    data['productPrice'] = productPrice;
    return data;
  }
}
