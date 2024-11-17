class UserModel {
  String? uId;
  String? userName;
  String? email;
  String? phone;
  String? userImg;
  String? userDeviceToken;
  String? country;
  String? userAddress;
  String? street;
  bool? isAdmin;
  bool? isActive;
  String? createdOn;
  String? city;

  UserModel(
      {this.uId,
        this.userName,
        this.email,
        this.phone,
        this.userImg,
        this.userDeviceToken,
        this.country,
        this.userAddress,
        this.street,
        this.isAdmin,
        this.isActive,
        this.createdOn,
        this.city
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    userImg = json['userImg'];
    userDeviceToken = json['userDeviceToken'];
    country = json['country'];
    userAddress = json['userAddress'];
    street = json['street'];
    isAdmin = json['isAdmin'];
    isActive = json['isActive'];
    createdOn = json['createdOn'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uId'] = this.uId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['userImg'] = this.userImg;
    data['userDeviceToken'] = this.userDeviceToken;
    data['country'] = this.country;
    data['userAddress'] = this.userAddress;
    data['street'] = this.street;
    data['isAdmin'] = this.isAdmin;
    data['isActive'] = this.isActive;
    data['createdOn'] = this.createdOn;
    data['city'] = this.city;
    return data;
  }
}