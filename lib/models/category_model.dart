class CategoryModel {
  String? categoryId;
  String? categoryImg;
  String? categoryName;
  dynamic createdAt;
  dynamic updatedAt;

  CategoryModel(
      {this.categoryId,
        this.categoryImg,
        this.categoryName,
        this.createdAt,
        this.updatedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryImg = json['categoryImg'];
    categoryName = json['categoryName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryImg'] = this.categoryImg;
    data['categoryName'] = this.categoryName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}