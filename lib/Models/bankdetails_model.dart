class BankDetailsModel {
  String? msg;
  bool? status;
  Data? data;

  BankDetailsModel({this.msg, this.status, this.data});

  BankDetailsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? bankDetailId;
  String? userId;
  String? bankName;
  String? branchAddress;
  String? acHolderName;
  String? acNumber;
  String? ifscCode;
  String? paytmNumber;
  String? googlePayNumber;
  String? phonePayNumber;
  String? insertDate;
  String? requestAdmin;

  Data(
      {this.bankDetailId,
        this.userId,
        this.bankName,
        this.branchAddress,
        this.acHolderName,
        this.acNumber,
        this.ifscCode,
        this.paytmNumber,
        this.googlePayNumber,
        this.phonePayNumber,
        this.insertDate,
        this.requestAdmin});

  Data.fromJson(Map<String, dynamic> json) {
    bankDetailId = json['bank_detail_id'];
    userId = json['user_id'];
    bankName = json['bank_name'];
    branchAddress = json['branch_address'];
    acHolderName = json['ac_holder_name'];
    acNumber = json['ac_number'];
    ifscCode = json['ifsc_code'];
    paytmNumber = json['paytm_number'];
    googlePayNumber = json['google_pay_number'];
    phonePayNumber = json['phone_pay_number'];
    insertDate = json['insert_date'];
    requestAdmin = json['request_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_detail_id'] = this.bankDetailId;
    data['user_id'] = this.userId;
    data['bank_name'] = this.bankName;
    data['branch_address'] = this.branchAddress;
    data['ac_holder_name'] = this.acHolderName;
    data['ac_number'] = this.acNumber;
    data['ifsc_code'] = this.ifscCode;
    data['paytm_number'] = this.paytmNumber;
    data['google_pay_number'] = this.googlePayNumber;
    data['phone_pay_number'] = this.phonePayNumber;
    data['insert_date'] = this.insertDate;
    data['request_admin'] = this.requestAdmin;
    return data;
  }
}
