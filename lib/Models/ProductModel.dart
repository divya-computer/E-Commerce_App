class ProductModel {
  String? flag;
  String? message;
  String? userId;
  String? userName;
  String? userMobile;
  String? userEmail;
  String? userGender;
  String? userAddress;
  String? userPhoto;

  ProductModel(
      {this.flag,
      this.message,
      this.userId,
      this.userName,
      this.userMobile,
      this.userEmail,
      this.userGender,
      this.userAddress,
      this.userPhoto});

  ProductModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    message = json['message'];
    userId = json['user_id'];
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    userEmail = json['user_email'];
    userGender = json['user_gender'];
    userAddress = json['user_address'];
    userPhoto = json['user_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_mobile'] = this.userMobile;
    data['user_email'] = this.userEmail;
    data['user_gender'] = this.userGender;
    data['user_address'] = this.userAddress;
    data['user_photo'] = this.userPhoto;
    return data;
  }
}
