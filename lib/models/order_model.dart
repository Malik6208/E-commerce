class OrdersModel {
  OrdersModel({
    required this.createdAt,
    required this.deliveryTime,
    required this.fullPrice,
    required this.isSale,
    required this.productDescription,
    required this.productId,
    required this.productImages,
    required this.productName,
    required this.salePrice,
    required this.productQuantity,
    required this.productFullPrice,
    required this.status,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerPinCode,
    required this.customerDeviceToken,
    required this.customerId,

  });
  late final String createdAt;
  late final String deliveryTime;
  late final int fullPrice;
  late final bool isSale;
  late final String productDescription;
  late final String productId;
  late final String productImages;
  late final String productName;
  late final String salePrice;
  late final int productQuantity;
  late final double productFullPrice;
  late final bool status;
  late final String customerName;
  late final String customerPhone;
  late final String customerAddress;
  late final String customerPinCode;
  late final String customerDeviceToken;
  late final String customerId;



  OrdersModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    deliveryTime = json['deliveryTime'];
    fullPrice = json['fullPrice'];
    isSale = json['isSale'];
    productDescription = json['productDescription'];
    productId = json['productId'];
    productImages = json['productImages'];
    productName = json['productName'];
    salePrice = json['salePrice'];
    productQuantity=json['productQuantity'];
    productFullPrice=json['productFullPrice'];
    status=json['status'];
    customerName=json['customerName'];
    customerPhone=json['customerPhone'];
    customerAddress=json['customerAddress'];
    customerPinCode=json['customerPinCode'];
    customerDeviceToken=json['customerDeviceToken'];
    customerId=json['customerId'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdAt'] = createdAt;
    _data['deliveryTime'] = deliveryTime;
    _data['fullPrice'] = fullPrice;
    _data['isSale'] = isSale;
    _data['productDescription'] = productDescription;
    _data['productId'] = productId;
    _data['productImages'] = productImages;
    _data['productName'] = productName;
    _data['salePrice'] = salePrice;
    _data['productQuantity'] = productQuantity;
    _data['productFullPrice'] = productFullPrice;
    _data['status'] = status;
    _data['customerName'] = customerName;
    _data['customerPhone'] = customerPhone;
    _data['customerAddress'] = customerAddress;
    _data['customerPinCode'] = customerPinCode;
    _data['customerDeviceToken'] = customerDeviceToken;
    _data['customerId'] = customerId;
    return _data;
  }
}
