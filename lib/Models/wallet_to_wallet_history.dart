class WalletToWalletHistoryModel {
  String? msg;
  bool? status;
  List<Data>? data;

  WalletToWalletHistoryModel({this.msg, this.status, this.data});

  WalletToWalletHistoryModel.fromJson(Map<String, dynamic> json) {
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
  String? userName;
  String? email;
  String? amount;
  String? transactionNote;
  String? sendType;

  Data(
      {this.userName,
        this.email,
        this.amount,
        this.transactionNote,
        this.sendType});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    email = json['email'];
    amount = json['amount'];
    transactionNote = json['transaction_note'];
    sendType = json['send_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['amount'] = this.amount;
    data['transaction_note'] = this.transactionNote;
    data['send_type'] = this.sendType;
    return data;
  }
}
