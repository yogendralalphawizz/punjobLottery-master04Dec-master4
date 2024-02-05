class DashboardModel {
  Msg? msg;

  DashboardModel({this.msg});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'] != null ? new Msg.fromJson(json['msg']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.msg != null) {
      data['msg'] = this.msg!.toJson();
    }
    return data;
  }
}

class Msg {
  String? referredBy;
  String? active;
  String? inactive;
  String? todayAmount;
  String? totalAmount;
  String? walletBalance;

  Msg(
      {this.referredBy,
        this.active,
        this.inactive,
        this.todayAmount,
        this.totalAmount,
        this.walletBalance});

  Msg.fromJson(Map<String, dynamic> json) {
    referredBy = json['referred_by'];
    active = json['active'];
    inactive = json['inactive'];
    todayAmount = json['today_amount'];
    totalAmount = json['total_amount'];
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referred_by'] = this.referredBy;
    data['active'] = this.active;
    data['inactive'] = this.inactive;
    data['today_amount'] = this.todayAmount;
    data['total_amount'] = this.totalAmount;
    data['wallet_balance'] = this.walletBalance;
    return data;
  }
}
