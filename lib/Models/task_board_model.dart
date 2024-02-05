class TaskboardListModel {
  String? msg;
  bool? status;
  List<Data>? data;

  TaskboardListModel({this.msg, this.status, this.data});

  TaskboardListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? packageId;
  String? price;
  String? perMinute;
  String? golTime;
  String? runPay;
  String? status;

  Data(
      {this.id,
        this.packageId,
        this.price,
        this.perMinute,
        this.golTime,
        this.runPay,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['package_id'];
    price = json['price'];
    perMinute = json['per_minute'];
    golTime = json['gol_time'];
    runPay = json['run_pay'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_id'] = this.packageId;
    data['price'] = this.price;
    data['per_minute'] = this.perMinute;
    data['gol_time'] = this.golTime;
    data['run_pay'] = this.runPay;
    data['status'] = this.status;
    return data;
  }
}
