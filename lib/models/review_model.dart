class ReviewModel {
  ReviewModel({
    required this.customerName,
    required this.customerPhone,
    required this.customerProfilePic,
    required this.customerDeviceToken,
    required this.orderId,
    required this.productId,
    required this.feedback,
    required this.rating,
    required this.createdAt,
  });
  late final String customerName;
  late final String customerPhone;
  late final String customerProfilePic;
  late final String customerDeviceToken;
  late final String orderId;
  late final String productId;
  late final String feedback;
  late final String rating;
  late final dynamic createdAt;


  ReviewModel.fromJson(Map<String, dynamic> json){
    customerName = json['customerName'];
    customerPhone = json['customerPhone'];
    customerProfilePic = json['customerProfilePic'];
    customerDeviceToken = json['customerDeviceToken'];
    orderId = json['customerId'];
    productId = json['productId'];
    feedback = json['feedback'];
    rating = json['rating'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerName'] = customerName;
    _data['customerPhone'] = customerPhone;
    _data['customerProfilePic'] = customerProfilePic;
    _data['customerDeviceToken'] = customerDeviceToken;
    _data['customerId'] = orderId;
    _data['productId'] = productId;
    _data['feedback'] = feedback;
    _data['rating'] = rating;
    _data['createdAt'] = createdAt;
    return _data;
  }
}