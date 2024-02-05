class PlanStartModel {
  bool? status;
  String? message;
  Data? data;

  PlanStartModel({this.status, this.message, this.data});

  PlanStartModel.fromJson(Map<String, dynamic> json) {
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
  List<Game>? game;
  int? second;
  String? minute;
  String? houre;
  String? golTimeHoure;
  int? golTimeMinute;

  Data(
      {this.game,
        this.second,
        this.minute,
        this.houre,
        this.golTimeHoure,
        this.golTimeMinute});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Game'] != null) {
      game = <Game>[];
      json['Game'].forEach((v) {
        game!.add(new Game.fromJson(v));
      });
    }
    second = json['second'];
    minute = json['minute'];
    houre = json['houre'];
    golTimeHoure = json['gol_time_houre'];
    golTimeMinute = json['gol_time_minute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.game != null) {
      data['Game'] = this.game!.map((v) => v.toJson()).toList();
    }
    data['second'] = this.second;
    data['minute'] = this.minute;
    data['houre'] = this.houre;
    data['gol_time_houre'] = this.golTimeHoure;
    data['gol_time_minute'] = this.golTimeMinute;
    return data;
  }
}

class Game {
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
  String? packageEndDate;
  String? packageStartDate;

  Game(
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
        this.sno,
        this.packageEndDate,
        this.packageStartDate});

  Game.fromJson(Map<String, dynamic> json) {
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
    packageEndDate = json['package_end_date'];
    packageStartDate = json['package_start_date'];
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
    data['package_end_date'] = this.packageEndDate;
    data['package_start_date'] = this.packageStartDate;
    return data;
  }
}
