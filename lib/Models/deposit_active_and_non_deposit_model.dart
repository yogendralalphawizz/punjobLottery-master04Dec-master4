class DepositTeamModel {
  String? msg;
  bool? status;
  Data? data;

  DepositTeamModel({this.msg, this.status, this.data});

  DepositTeamModel.fromJson(Map<String, dynamic> json) {
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
  int? depositDeactive;
  String? depositActive;
  List<DepositDeactiveData>? depositActiveData;
  List<DepositDeactiveData>? depositDeactiveData;

  Data(
      {this.depositDeactive,
        this.depositActive,
        this.depositActiveData,
        this.depositDeactiveData});

  Data.fromJson(Map<String, dynamic> json) {
    depositDeactive = json['deposit_deactive'];
    depositActive = json['deposit_active'];
    if (json['deposit_active_data'] != null) {
      depositActiveData = <DepositDeactiveData>[];
      json['deposit_active_data'].forEach((v) {
        depositActiveData!.add(new DepositDeactiveData.fromJson(v));
      });
    }
    if (json['deposit_deactive_data'] != null) {
      depositDeactiveData = <DepositDeactiveData>[];
      json['deposit_deactive_data'].forEach((v) {
        depositDeactiveData!.add(new DepositDeactiveData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deposit_deactive'] = this.depositDeactive;
    data['deposit_active'] = this.depositActive;
    if (this.depositActiveData != null) {
      data['deposit_active_data'] =
          this.depositActiveData!.map((v) => v.toJson()).toList();
    }
    if (this.depositDeactiveData != null) {
      data['deposit_deactive_data'] =
          this.depositDeactiveData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DepositDeactiveData {
  String? userName;
  String? email;

  DepositDeactiveData({this.userName, this.email});

  DepositDeactiveData.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['email'] = this.email;
    return data;
  }
}
