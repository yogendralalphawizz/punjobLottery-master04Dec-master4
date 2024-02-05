class RuningModel {
  String? msg;
  bool? status;
  List<Data>? data;

  RuningModel({this.msg, this.status, this.data});

  RuningModel.fromJson(Map<String, dynamic> json) {
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
  String? gameId;
  String? packageSettingId;
  String? userId;
  String? startTime;
  String? closeTime;
  String? amount;
  String? markStatus;
  String? staus;
  String? gameStatus;
  String? tMinute;
  String? tMinutePrice;
  String? tHoure;
  String? tHourePrice;
  String? checkStatus;
  String? sno;

  Data(
      {this.id,
        this.gameId,
        this.packageSettingId,
        this.userId,
        this.startTime,
        this.closeTime,
        this.amount,
        this.markStatus,
        this.staus,
        this.gameStatus,
        this.tMinute,
        this.tMinutePrice,
        this.tHoure,
        this.tHourePrice,
        this.checkStatus,
        this.sno});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['game_id'];
    packageSettingId = json['package_setting_id'];
    userId = json['user_id'];
    startTime = json['start_time'];
    closeTime = json['close_time'];
    amount = json['amount'];
    markStatus = json['mark_status'];
    staus = json['staus'];
    gameStatus = json['game_status'];
    tMinute = json['t_minute'];
    tMinutePrice = json['t_minute_price'];
    tHoure = json['t_houre'];
    tHourePrice = json['t_houre_price'];
    checkStatus = json['check_status'];
    sno = json['sno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['game_id'] = this.gameId;
    data['package_setting_id'] = this.packageSettingId;
    data['user_id'] = this.userId;
    data['start_time'] = this.startTime;
    data['close_time'] = this.closeTime;
    data['amount'] = this.amount;
    data['mark_status'] = this.markStatus;
    data['staus'] = this.staus;
    data['game_status'] = this.gameStatus;
    data['t_minute'] = this.tMinute;
    data['t_minute_price'] = this.tMinutePrice;
    data['t_houre'] = this.tHoure;
    data['t_houre_price'] = this.tHourePrice;
    data['check_status'] = this.checkStatus;
    data['sno'] = this.sno;
    return data;
  }
}
