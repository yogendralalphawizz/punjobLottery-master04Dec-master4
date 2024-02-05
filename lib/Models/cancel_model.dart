class CancelModel {
  bool? status;
  String? message;
  Data? data;

  CancelModel({this.status, this.message, this.data});

  CancelModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? userId;
  String? time;
  String? cancelCount;

  Data({this.id, this.userId, this.time, this.cancelCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    time = json['time'];
    cancelCount = json['cancel_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['time'] = this.time;
    data['cancel_count'] = this.cancelCount;
    return data;
  }
}
