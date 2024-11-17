class ProductModel {
  ProductModel({
    required this.createdAt,
    required this.deliveryTime,
    required this.fullPrice,
    required this.isSale,
    required this.productDescription,
    required this.productId,
    required this.productImages,
    required this.productName,
    required this.salePrice,
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

  ProductModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    deliveryTime = json['deliveryTime'];
    fullPrice = json['fullPrice'];
    isSale = json['isSale'];
    productDescription = json['productDescription'];
    productId = json['productId'];
    productImages = json['productImages'];
    productName = json['productName'];
    salePrice = json['salePrice'];
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
    return _data;
  }
}
