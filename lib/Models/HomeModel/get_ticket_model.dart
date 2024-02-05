class GetTicketsModel {
  List<Data>? data;
  String? msg;
  bool? status;

  GetTicketsModel({this.data, this.msg, this.status});

  GetTicketsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? dateCreated;

  Data({this.id, this.title, this.dateCreated});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date_created'] = this.dateCreated;
    return data;
  }
}
