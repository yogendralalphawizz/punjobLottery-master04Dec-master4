class GetmasterAdmincodeModel {
  bool? status;
  String? message;
  Data? data;

  GetmasterAdmincodeModel({this.status, this.message, this.data});

  GetmasterAdmincodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? referredBy;

  Data({this.referredBy});

  Data.fromJson(Map<String, dynamic> json) {
    referredBy = json['referred_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referred_by'] = this.referredBy;
    return data;
  }
}
