class GetAllDepositBalanceModel {
  String? msg;
  bool? status;
  Data? data;

  GetAllDepositBalanceModel({this.msg, this.status, this.data});

  GetAllDepositBalanceModel.fromJson(Map<String, dynamic> json) {
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
  String? depositAmount;
  List<DepositHistory>? depositHistory;

  Data({this.depositAmount, this.depositHistory});

  Data.fromJson(Map<String, dynamic> json) {
    depositAmount = json['deposit_amount'];
    if (json['deposit_history'] != null) {
      depositHistory = <DepositHistory>[];
      json['deposit_history'].forEach((v) {
        depositHistory!.add(new DepositHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deposit_amount'] = this.depositAmount;
    if (this.depositHistory != null) {
      data['deposit_history'] =
          this.depositHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DepositHistory {
  String? transactionId;
  String? userId;
  String? amount;
  String? transactionType;
  String? transactionNote;
  String? transferNote;
  String? amountStatus;
  String? insertDate;
  String? txRequestNumber;
  String? txnId;
  String? txnRef;
  String? openResultToken;
  String? closeResultToken;
  String? bidTxId;
  String? userIdto;

  DepositHistory(
      {this.transactionId,
        this.userId,
        this.amount,
        this.transactionType,
        this.transactionNote,
        this.transferNote,
        this.amountStatus,
        this.insertDate,
        this.txRequestNumber,
        this.txnId,
        this.txnRef,
        this.openResultToken,
        this.closeResultToken,
        this.bidTxId,
        this.userIdto});

  DepositHistory.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    userId = json['user_id'];
    amount = json['amount'];
    transactionType = json['transaction_type'];
    transactionNote = json['transaction_note'];
    transferNote = json['transfer_note'];
    amountStatus = json['amount_status'];
    insertDate = json['insert_date'];
    txRequestNumber = json['tx_request_number'];
    txnId = json['txn_id'];
    txnRef = json['txn_ref'];
    openResultToken = json['open_result_token'];
    closeResultToken = json['close_result_token'];
    bidTxId = json['bid_tx_id'];
    userIdto = json['user_idto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['transaction_type'] = this.transactionType;
    data['transaction_note'] = this.transactionNote;
    data['transfer_note'] = this.transferNote;
    data['amount_status'] = this.amountStatus;
    data['insert_date'] = this.insertDate;
    data['tx_request_number'] = this.txRequestNumber;
    data['txn_id'] = this.txnId;
    data['txn_ref'] = this.txnRef;
    data['open_result_token'] = this.openResultToken;
    data['close_result_token'] = this.closeResultToken;
    data['bid_tx_id'] = this.bidTxId;
    data['user_idto'] = this.userIdto;
    return data;
  }
}
