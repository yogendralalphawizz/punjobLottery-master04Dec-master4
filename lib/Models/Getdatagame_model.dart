class GetgamedataModel {
  bool? status;
  String? message;
  Data? data;

  GetgamedataModel({this.status, this.message, this.data});

  GetgamedataModel.fromJson(Map<String, dynamic> json) {
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
  String? time;
  String? jsonData;

  Data({this.time, this.jsonData});

  Data.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    jsonData = json['json_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['json_data'] = this.jsonData;
    return data;
  }
}
