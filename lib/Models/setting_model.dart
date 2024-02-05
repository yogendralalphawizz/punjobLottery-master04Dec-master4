class SettingModel {
  String? msg;
  bool? status;
  Data? data;

  SettingModel({this.msg, this.status, this.data});

  SettingModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? amount;
  String? type;
  String? status;
  String? sAmount;
  String? sType;
  String? sStatus;
  String? rAmount;
  String? rType;
  String? rStatus;
  String? loginType;
  String? mappingCount;

  Data(
      {this.id,
        this.amount,
        this.type,
        this.status,
        this.sAmount,
        this.sType,
        this.sStatus,
        this.rAmount,
        this.rType,
        this.rStatus,
        this.loginType,
        this.mappingCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    type = json['type'];
    status = json['status'];
    sAmount = json['s_amount'];
    sType = json['s_type'];
    sStatus = json['s_status'];
    rAmount = json['r_amount'];
    rType = json['r_type'];
    rStatus = json['r_status'];
    loginType = json['login_type'];
    mappingCount = json['mapping_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['status'] = this.status;
    data['s_amount'] = this.sAmount;
    data['s_type'] = this.sType;
    data['s_status'] = this.sStatus;
    data['r_amount'] = this.rAmount;
    data['r_type'] = this.rType;
    data['r_status'] = this.rStatus;
    data['login_type'] = this.loginType;
    data['mapping_count'] = this.mappingCount;
    return data;
  }
}
