class RolesListModel {
  String? msg;
  bool? status;
  Data? data;

  RolesListModel({this.msg, this.status, this.data});

  RolesListModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? managemantRole;
  String? refferalRole;
  String? withdrawalRole;
  String? playerRole;

  Data(
      {this.id,
        this.managemantRole,
        this.refferalRole,
        this.withdrawalRole,
        this.playerRole});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    managemantRole = json['managemant_role'];
    refferalRole = json['refferal_role'];
    withdrawalRole = json['withdrawal_role'];
    playerRole = json['player_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['managemant_role'] = this.managemantRole;
    data['refferal_role'] = this.refferalRole;
    data['withdrawal_role'] = this.withdrawalRole;
    data['player_role'] = this.playerRole;
    return data;
  }
}
