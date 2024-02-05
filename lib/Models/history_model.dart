class HistoryModel {
  bool? status;
  List<Data>? data;
  String? message;

  HistoryModel({this.status, this.data, this.message});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? packageSettingId;
  String? markStatus;
  String? status;
  String? openDecleareDate;
  String? closeDecleareDate;
  String? second;
  String? secondAmount;
  String? minute;
  String? minutePrice;
  String? houre;
  String? hourePrice;
  String? amount;
  int? packagePrice;

  Data(
      {this.id,
        this.packageSettingId,
        this.markStatus,
        this.status,
        this.openDecleareDate,
        this.closeDecleareDate,
        this.second,
        this.secondAmount,
        this.minute,
        this.minutePrice,
        this.houre,
        this.hourePrice,
        this.amount,
        this.packagePrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageSettingId = json['package_setting_id'];
    markStatus = json['mark_status'];
    status = json['status'];
    openDecleareDate = json['open_decleare_date'];
    closeDecleareDate = json['close_decleare_date'];
    second = json['second'];
    secondAmount = json['second_amount'];
    minute = json['minute'];
    minutePrice = json['minute_price'];
    houre = json['houre'];
    hourePrice = json['houre_price'];
    amount = json['amount'];
    packagePrice = json['package_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_setting_id'] = this.packageSettingId;
    data['mark_status'] = this.markStatus;
    data['status'] = this.status;
    data['open_decleare_date'] = this.openDecleareDate;
    data['close_decleare_date'] = this.closeDecleareDate;
    data['second'] = this.second;
    data['second_amount'] = this.secondAmount;
    data['minute'] = this.minute;
    data['minute_price'] = this.minutePrice;
    data['houre'] = this.houre;
    data['houre_price'] = this.hourePrice;
    data['amount'] = this.amount;
    data['package_price'] = this.packagePrice;
    return data;
  }
}
