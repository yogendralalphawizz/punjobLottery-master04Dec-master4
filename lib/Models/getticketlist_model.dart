class GetTicketsListModel {
  String? msg;
  List<Data>? data;
  bool? status;

  GetTicketsListModel({this.msg, this.data, this.status});

  GetTicketsListModel.fromJson(Map<String, dynamic> json) {
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
  String? ticketTypeId;
  String? userId;
  String? subject;
  String? phone;
  String? email;
  String? description;
  String? status;
  String? lastUpdated;
  String? dateCreated;
  String? saleId;

  Data(
      {this.id,
        this.ticketTypeId,
        this.userId,
        this.subject,
        this.phone,
        this.email,
        this.description,
        this.status,
        this.lastUpdated,
        this.dateCreated,
        this.saleId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketTypeId = json['ticket_type_id'];
    userId = json['user_id'];
    subject = json['subject'];
    phone = json['phone'];
    email = json['email'];
    description = json['description'];
    status = json['status'];
    lastUpdated = json['last_updated'];
    dateCreated = json['date_created'];
    saleId = json['sale_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_type_id'] = this.ticketTypeId;
    data['user_id'] = this.userId;
    data['subject'] = this.subject;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['description'] = this.description;
    data['status'] = this.status;
    data['last_updated'] = this.lastUpdated;
    data['date_created'] = this.dateCreated;
    data['sale_id'] = this.saleId;
    return data;
  }
}
