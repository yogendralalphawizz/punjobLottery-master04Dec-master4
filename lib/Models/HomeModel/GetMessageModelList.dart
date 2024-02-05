class GetMessageModelList {
  String? msg;
  List<Data>? data;
  bool? status;

  GetMessageModelList({this.msg, this.data, this.status});

  GetMessageModelList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? id;
  String? userType;
  String? userId;
  String? ticketId;
  String? message;
  String? attachments;
  String? lastUpdated;
  String? dateCreated;

  Data(
      {this.id,
        this.userType,
        this.userId,
        this.ticketId,
        this.message,
        this.attachments,
        this.lastUpdated,
        this.dateCreated});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userId = json['user_id'];
    ticketId = json['ticket_id'];
    message = json['message'];
    attachments = json['attachments'];
    lastUpdated = json['last_updated'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['user_id'] = this.userId;
    data['ticket_id'] = this.ticketId;
    data['message'] = this.message;
    data['attachments'] = this.attachments;
    data['last_updated'] = this.lastUpdated;
    data['date_created'] = this.dateCreated;
    return data;
  }
}
