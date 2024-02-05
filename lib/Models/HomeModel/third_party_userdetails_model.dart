class ThirdpartyModel {
  bool? status;
  String? message;
  List<Data>? data;

  ThirdpartyModel({this.status, this.message, this.data});

  ThirdpartyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userId;
  dynamic unUserId;
  String? userName;
  String? email;
  dynamic dob;
  String? mobile;
  String? password;
  String? apiKey;
  String? referralCode;
  String? referredBy;
  dynamic aadhaarNumber;
  dynamic panCard;
  dynamic cityPin;
  String? securityPin;
  String? image;
  dynamic address;
  String? walletBalance;
  String? holdAmount;
  String? lastUpdate;
  String? insertDate;
  String? status;
  String? verified;
  String? bettingStatus;
  String? notificationStatus;
  String? transferPointStatus;
  String? transactionId;
  String? firstRecharge;
  dynamic ?referedbyamount;

  Data(
      {this.userId,
        this.unUserId,
        this.userName,
        this.email,
        this.dob,
        this.mobile,
        this.password,
        this.apiKey,
        this.referralCode,
        this.referredBy,
        this.aadhaarNumber,
        this.panCard,
        this.cityPin,
        this.securityPin,
        this.image,
        this.address,
        this.walletBalance,
        this.holdAmount,
        this.lastUpdate,
        this.insertDate,
        this.status,
        this.verified,
        this.bettingStatus,
        this.notificationStatus,
        this.transferPointStatus,
        this.transactionId,
        this.firstRecharge,
        this.referedbyamount
      });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    unUserId = json['un_user_id'];
    userName = json['user_name'];
    email = json['email'];
    dob = json['dob'];
    mobile = json['mobile'];
    password = json['password'];
    apiKey = json['api_key'];
    referralCode = json['referral_code'];
    referredBy = json['referred_by'];
    aadhaarNumber = json['aadhaar_number'];
    panCard = json['pan_card'];
    cityPin = json['city_pin'];
    securityPin = json['security_pin'];
    image = json['image'];
    address = json['address'];
    walletBalance = json['wallet_balance'];
    holdAmount = json['hold_amount'];
    lastUpdate = json['last_update'];
    insertDate = json['insert_date'];
    status = json['status'];
    verified = json['verified'];
    bettingStatus = json['betting_status'];
    notificationStatus = json['notification_status'];
    transferPointStatus = json['transfer_point_status'];
    transactionId = json['transaction_id'];
    firstRecharge = json['first_recharge'];
    referedbyamount=json['referred_by_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['un_user_id'] = this.unUserId;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['api_key'] = this.apiKey;
    data['referral_code'] = this.referralCode;
    data['referred_by'] = this.referredBy;
    data['aadhaar_number'] = this.aadhaarNumber;
    data['pan_card'] = this.panCard;
    data['city_pin'] = this.cityPin;
    data['security_pin'] = this.securityPin;
    data['image'] = this.image;
    data['address'] = this.address;
    data['wallet_balance'] = this.walletBalance;
    data['hold_amount'] = this.holdAmount;
    data['last_update'] = this.lastUpdate;
    data['insert_date'] = this.insertDate;
    data['status'] = this.status;
    data['verified'] = this.verified;
    data['betting_status'] = this.bettingStatus;
    data['notification_status'] = this.notificationStatus;
    data['transfer_point_status'] = this.transferPointStatus;
    data['transaction_id'] = this.transactionId;
    data['first_recharge'] = this.firstRecharge;
    data['referred_by_amount']=this.referedbyamount;
    return data;
  }
}
