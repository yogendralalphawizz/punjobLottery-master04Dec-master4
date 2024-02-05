import 'dart:convert';

import 'package:booknplay/Screens/AddMoney/add_money.dart';
import 'package:booknplay/Screens/Management/wallet_to_wallet_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_profile_model.dart';
import '../../Models/HomeModel/wallet_blanced_model.dart';
import '../../Models/all_deposit_balance.dart';
import '../../Models/get_all_transaction_model.dart';
import '../../Models/list_rols.dart';
import '../../Models/wallet_to_wallet_history.dart';
import '../../Models/wallet_to_wallet_model.dart';
import '../../Models/withdrawal_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Utils/Colors.dart';
import '../Profile/bank_details.dart';
import '../Withdrawal/withdrawal_view.dart';
import 'All_transaction_screen.dart';
import 'deposit_history.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  WalletToWalletTransferModel walletToWalletTransferModel =
      WalletToWalletTransferModel();
  StateSetter? dialogState;
  final _formKey = GlobalKey<FormState>();
  bool isAddmoney = false;
  GetAllDepositBalanceModel getAllDepositBalanceModel =
      GetAllDepositBalanceModel();
  WalletToWalletHistoryModel walletHistoryModel = WalletToWalletHistoryModel();
  GetAllTransactionHistoryModel getAllTransactionHistoryModel =
      GetAllTransactionHistoryModel();
  RolesListModel rolesListModel = RolesListModel();
  getWallettowallet() async {
    Map<String, String> body = {
      'user_id': "20"
      //await SharedPre.getStringValue('userId'),
    };
    final response = await http.post(
        Uri.parse('${baseUrl}pointTopoint_reffralList'),
        body: jsonEncode(body));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      walletToWalletTransferModel = WalletToWalletTransferModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }
  GetProfileModel? getProfileModel;
  GetProfileModel? getProfileModel1;
  getProfile(String id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}apiGetProfile'));
    request.body = json.encode({
      "user_id": "${id}"
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      print(result);
      var finalResult = GetProfileModel.fromJson(json.decode(result));
      setState(() {
        getProfileModel= finalResult;
      });
      Fluttertoast.showToast(msg: "${finalResult.msg}");
    }
    else {
      print(response.reasonPhrase);
    }

  }
  TextEditingController enterpiccon=TextEditingController();
  getProfile1(String id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}apiGetProfile'));
    request.body = json.encode({
      "user_id": "${id}"
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      print(result);
      var finalResult = GetProfileModel.fromJson(json.decode(result));
      setState(() {
        getProfileModel1= finalResult;
      });
      Fluttertoast.showToast(msg: "${finalResult.msg}");
    }
    else {
      print(response.reasonPhrase);
    }

  }
  getbalance() async {
    Map<String, String> body = {
      'user_id': await SharedPre.getStringValue('userId'),
    };
    final response = await http.post(
        Uri.parse('${baseUrl}api_getAllDepositBalance'),
        body: jsonEncode(body));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      getAllDepositBalanceModel = GetAllDepositBalanceModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  selectoptionupdate(String type) async {
    Map<String, String> body = {
      'user_id': await SharedPre.getStringValue('userId'),
      "type": type
    };
    final response = await http.post(
        Uri.parse('${baseUrl}api_referral_income_mapping'),
        body: jsonEncode(body));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "${data["message"]}", backgroundColor: AppColors.fntClr);
    } else {
      print(response.reasonPhrase);
    }
  }

  walletTowalletHistory() async {
    Map<String, String> body = {
      'user_id': await SharedPre.getStringValue('userId'),
      //await SharedPre.getStringValue('userId'),
    };
    final response = await http.post(
        Uri.parse('${baseUrl}poinTopoint_refTranHistory'),
        body: jsonEncode(body));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      walletHistoryModel = WalletToWalletHistoryModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  WalletModel walletModel = WalletModel();
  WithdrawalModel withdrawalModel=WithdrawalModel();

  getWalletblance() async {
    Map<String, String> body = {
      'user_id': await SharedPre.getStringValue('userId'),
    };
    print(body);
    final response = await http.post(Uri.parse('${baseUrl}wallet_balance'),
        body: jsonEncode(body));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      walletModel = WalletModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }
  getWithdrawalblance() async {
    Map<String, String> body = {
      'user_id': await SharedPre.getStringValue('userId'),
    };
    print(body);
    final response = await http.post(Uri.parse('${baseUrl}api_withdrawal_amount'),
        body: jsonEncode(body));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      withdrawalModel = WithdrawalModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  getRols() async {
    // Map<String,String> body={
    //   'user_id':await SharedPre.getStringValue('userId'),
    //
    // };
    //  print(body);
    final response = await http.post(Uri.parse('${baseUrl}api_ListofRoles'));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      rolesListModel = RolesListModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  GetAllTransactionHistory() async {
    Map<String, String> body = {
      'user_id': await SharedPre.getStringValue('userId'),
      //await SharedPre.getStringValue('userId'),
    };
    final response = await http.post(
        Uri.parse('${baseUrl}api_AllTransactionHistory'),
        body: jsonEncode(body));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      getAllTransactionHistoryModel =
          GetAllTransactionHistoryModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  walletTowallettransfer() async {
    Map<String, String> body = {
      'user_id': await SharedPre.getStringValue('userId'),
      'from_user_id': "${ID.text}",
      "amount": "${amtC.text}"
    };
    final response = await http.post(
        Uri.parse('${baseUrl}add_pointTopoint_reffral_amount'),
        body: jsonEncode(body));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "${data["msg"]}", backgroundColor: AppColors.primary);
      Navigator.pop(context);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  TextEditingController amtC = TextEditingController();
  TextEditingController ID = TextEditingController();
  dynamic? stateId;
  String? selectoption;
  _showDialog() async {
    bool payWarn = false;
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
          dialogState = setStater;
          return FutureBuilder(
            future: getProfile(ID.text),
            builder: (context, snapshot) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(0.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                      child: Text(
                        "Transfer Money Wallet To Wallet",
                        style: TextStyle(color: AppColors.fntClr),
                      ),
                    ),
                    Card(
                      color: AppColors.whit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Name : ", style: TextStyle(color: AppColors.fntClr, fontWeight: FontWeight.bold)),
                                        Text("${getProfileModel?.profile?.userName ?? ""}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Wallet Amount : ", style: TextStyle(color: AppColors.fntClr, fontWeight: FontWeight.bold)),
                                        Text("${getProfileModel?.profile?.walletBalance ?? ""}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("ReferralCode : ", style: TextStyle(color: AppColors.fntClr, fontWeight: FontWeight.bold)),
                                        Text("${getProfileModel?.profile?.referralCode ?? ""}"),
                                      ],
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text("User Id : ", style: TextStyle(color: AppColors.fntClr, fontWeight: FontWeight.bold)),
                                    //     Text("${getProfileModel?.profile?.userId ?? ""}"),
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(
                                    color: AppColors.fntClr,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter ID',
                                    hintStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  controller: ID,
                                  onChanged: (value) {
                                    // Don't call getProfile here; it will be handled by FutureBuilder
                                    setStater(() {});
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(
                                    color: AppColors.fntClr,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter Amount',
                                    hintStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  controller: amtC,
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: AppColors.fntClr, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Send',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: AppColors.fntClr, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (amtC.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please enter amount",
                            backgroundColor: AppColors.primary);
                        return;
                      } else {
                        Navigator.pop(context);
                        _showBottomSheet();
                     //   walletTowallettransfer();
                      }
                    },
                  ),
                ],
              );
            },
          );
        })
    );
  }

  dialogAnimate(BuildContext context, Widget dialog) {
    return showGeneralDialog(
      barrierColor: Colors.transparent,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(opacity: a1.value, child: dialog),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  controller: enterpiccon,
                  decoration: InputDecoration(
                    hintText: 'Enter 4-digit number',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle submit logic here
                    // print("${enterpiccon.text}"+"-----");
                    // print("${getProfileModel1?.profile?.transactionId}"+"-----");
                    //
                    // print("${getProfileModel1?.profile?.transactionId}"=="${enterpiccon.text}");
                    if(enterpiccon.text==""){
                      Fluttertoast.showToast(
                          msg: "Enter  Pin",
                          backgroundColor: AppColors.primary);
                    }else {
                      if (int.parse(
                          "${getProfileModel1?.profile?.transactionId}") ==
                          int.parse("${enterpiccon.text}")) {
                        walletTowallettransfer();
                        enterpiccon.clear();
                        amtC.clear();
                        // Navigator.pop(context);
                      }
                      else {
                        Fluttertoast.showToast(
                            msg: "Enter Wrong Pin",
                            backgroundColor: AppColors.primary);
                      }
                    }
                    // Close bottom sheet
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    getWallettowallet();
    getbalance();
    getWalletblance();
    walletTowalletHistory();
    getRols();
    GetAllTransactionHistory();
    getData();
    getWithdrawalblance();
    super.initState();
  }
getData() async {
  getProfile1( "${await SharedPre.getStringValue('userId')}");
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(
          "Management",
          style: TextStyle(fontSize: 17),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
           //    padding: EdgeInsets.symmetric(horizontal: 10,),

                decoration: BoxDecoration(
                    color: AppColors.whit,
                    border: Border.all(color: AppColors.fntClr),
                    borderRadius: BorderRadius.circular(11)),
                child: Column(
                  children: [
                    Container(
                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.whit,
                          border: Border.all(color: AppColors.fntClr),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.whit,
                                border: Border.all(color: AppColors.fntClr),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    "Deposit Balance",
                                    style: TextStyle(
                                        color: AppColors.fntClr,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(indent: 20, endIndent: 20, thickness: 2),
                                SizedBox(
                                  height: 10,
                                ),
                                Material(
                                  color: AppColors.whit,
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.whit,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Rs.${getAllDepositBalanceModel.data?.depositAmount ?? "0"}/-",
                                        style: TextStyle(
                                            color: AppColors.fntClr,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                    onTap: () {
                                      _showDialog();
                                    },
                                    child: buildContainer("P2P Transfer")),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return WalletToWalletHistory(
                                          walletToWalletHistoryModel:
                                              walletHistoryModel,
                                        );
                                      }));
                                    },
                                    child: buildContainer("P2P History")),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return AddMoney();
                                      })).then((value) => {});
                                    },
                                    child: buildContainer("Deposit-Recharge")),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return DepositHistoryScreen(
                                          getAllDepositBalanceModel:
                                              getAllDepositBalanceModel,
                                        );
                                      }));
                                    },
                                    child: buildContainer("Deposit-History")),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: HtmlWidget(
                        '''
           ${rolesListModel.data?.managemantRole ?? ""}
                                  ''',
                      ),
                    ),
                  ],
                ),
              ),
           //    HtmlWidget(
           //      '''
           // ${rolesListModel.data?.managemantRole ?? ""}
           //  ''',
           //    ),
              Container(
                margin:EdgeInsets.symmetric(vertical: 10,),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                    color: AppColors.whit,
                    border: Border.all(color: AppColors.fntClr),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Referral Income Mapping",
                        style: TextStyle(
                            color: AppColors.fntClr,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: AppColors.whit,
                                border: Border.all(color: AppColors.fntClr),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton<dynamic>(
                              hint: Text(
                                "Select Option",
                                style: TextStyle(color: Colors.black87),
                              ),
                              value: selectoption,
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.fntClr,
                              ),
                              items: ["Deposit", "Withdrawal"].map((value) {
                                return DropdownMenuItem<dynamic>(
                                  value: value,
                                  child: Text(value ?? ""),
                                );
                              }).toList(),
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (value) async {
                                setState(() {
                                  selectoption = value;
                                });

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: (){
                          if(selectoption==null){
                            Fluttertoast.showToast(
                                msg: "Please Select Income Mapping", backgroundColor: AppColors.fntClr);
                            return;
                          }
                          selectoptionupdate(
                              selectoption == "Deposit" ? "1" : "2");
                        },
                        child: buildContainer("Income Activation")),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: AppColors.whit,
                    border: Border.all(color: AppColors.fntClr),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(

                      decoration: BoxDecoration(
                          color: AppColors.whit,
                          border: Border.all(color: AppColors.fntClr),
                        borderRadius: BorderRadius.circular(10),),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Withdrawel Balance",
                              style: TextStyle(
                                  color: AppColors.fntClr,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(indent: 20, endIndent: 20, thickness: 2),
                          SizedBox(
                            height: 10,
                          ),
                          Material(
                            elevation: 2,
                              color: AppColors.whit,
                              borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.whit,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "${withdrawalModel.data?.withdrawalAmount ?? "0"}",
                                  style: TextStyle(
                                      color: AppColors.fntClr,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return WithdrawalScreen(
                                    index: 1,
                                  );
                                }));
                              },
                              child: buildContainer("Withdrawel")),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return WithdrawalScreen(
                                    index: 2,
                                  );
                                }));
                              },
                              child: buildContainer("Withdrawel-History")),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AllTransactionHistoryScreen(
                                    getAllTransactionHistoryModel:
                                        getAllTransactionHistoryModel,
                                  );
                                }));
                              },
                              child: buildContainer("All Transaction History")),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BankdetailsScreen();
                                }));
                              },
                              child: buildContainer("All Bank Details")),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HtmlWidget(
                      '''
           ${rolesListModel.data?.withdrawalRole ?? ""}
            ''',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
           //    HtmlWidget(
           //      '''
           // ${rolesListModel.data?.withdrawalRole ?? ""}
           //  ''',
           //    ),

              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material buildContainer(String title) {
    return Material(
      elevation: 2,
      color: AppColors.whit,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(color: AppColors.fntClr),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "${title}",
            style: TextStyle(
              color: AppColors.whit,
              fontSize: 16,
              // fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
