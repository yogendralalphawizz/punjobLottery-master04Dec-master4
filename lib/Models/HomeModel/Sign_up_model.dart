class SignUpModel {
  Data? data;
  String? msg;
  bool? status;

  SignUpModel({this.data, this.msg, this.status});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? userId;
  ReferralBy? referralBy;

  Data({this.userId, this.referralBy});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    referralBy = json['referral_by'] != null
        ? new ReferralBy.fromJson(json['referral_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    if (this.referralBy != null) {
      data['referral_by'] = this.referralBy!.toJson();
    }
    return data;
  }
}

class ReferralBy {
  String? amount;
  String? referralAmount;

  ReferralBy({this.amount, this.referralAmount});

  ReferralBy.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    referralAmount = json['referral_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['referral_amount'] = this.referralAmount;
    return data;
  }
}
