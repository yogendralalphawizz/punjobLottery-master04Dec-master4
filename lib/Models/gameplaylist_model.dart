class GameListModel {
  String? msg;
  bool? status;
  Data? data;

  GameListModel({this.msg, this.status, this.data});

  GameListModel.fromJson(Map<String, dynamic> json) {
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
  String? golTimeHoure;
  String? buyPrice;
  String? packageId;
  String? refferalIncome;
  String? packagePrice;
  String? minutes;
  String? minutePrice;
  String? houre;
  String? hourePrice;

  Data(
      {this.golTimeHoure,
        this.buyPrice,
        this.packageId,
        this.refferalIncome,
        this.packagePrice,
        this.minutes,
        this.minutePrice,
        this.houre,
        this.hourePrice});

  Data.fromJson(Map<String, dynamic> json) {
    golTimeHoure = json['gol_time_houre'];
    buyPrice = json['Buy_price'];
    packageId = json['package_id'];
    refferalIncome = json['refferal_income'];
    packagePrice = json['package_price'];
    minutes = json['minutes'];
    minutePrice = json['minute_price'];
    houre = json['houre'];
    hourePrice = json['houre_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gol_time_houre'] = this.golTimeHoure;
    data['Buy_price'] = this.buyPrice;
    data['package_id'] = this.packageId;
    data['refferal_income'] = this.refferalIncome;
    data['package_price'] = this.packagePrice;
    data['minutes'] = this.minutes;
    data['minute_price'] = this.minutePrice;
    data['houre'] = this.houre;
    data['houre_price'] = this.hourePrice;
    return data;
  }
}
