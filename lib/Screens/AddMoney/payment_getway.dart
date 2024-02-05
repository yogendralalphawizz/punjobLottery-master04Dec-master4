

import 'dart:convert';

import 'package:booknplay/Screens/AddMoney/add_money.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart'as http;

import '../../Local_Storage/shared_pre.dart';
import '../../Services/api_services/apiConstants.dart';

class Paymentgetway extends StatefulWidget {
  String orderid;
  String url;
  String amount;
   Paymentgetway({required this.amount,required this.orderid,required this.url});

  @override
  State<Paymentgetway> createState() => _PaymentgetwayState();
}

class _PaymentgetwayState extends State<Paymentgetway> {
  late final WebViewController _controller;

  sucessPayment1() async {
    Map<String,String> body={
      'user_id':await SharedPre.getStringValue('userId'),
      'amount':widget.amount,
      "txn_id":"test",
      "txn_ref":"asfdasf"
    };
    final response = await
    http.post(Uri.parse('${baseUrl}apiAddMoneyViaUpi'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    if (response.statusCode == 200) {


      Fluttertoast.showToast(msg:"${data['msg']}" );

      //getWalletblance();
      Navigator.pop(context);
    }
    else {
      // setState(() {
      //   isAddmoney =  false;
      // });
      print(response.reasonPhrase);
    }

    print('____request.fields______${body}_________');
  }
  @override
  void initState() {
    // TODO: implement initState
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('thankyou')) {
              sucessPayment1();
              print("+++++++++++++++++++++=");
              Get.off(()=>AddMoney());
             /// Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('${widget.url}'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
class PAYMENTSUCESSMODEL {
  String? code;
  String? status;
  String? mess;
  Data? data;

  PAYMENTSUCESSMODEL({this.code, this.status, this.mess, this.data});

  PAYMENTSUCESSMODEL.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    mess = json['mess'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['mess'] = this.mess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? orderKeyId;
  String? orderAmount;
  String? orderId;
  String? orderStatus;
  String? orderPaymentStatus;
  Null? orderPaymentStatusText;
  String? paymentStatus;
  Null? paymentTransactionId;
  String? paymentResponseCode;
  Null? paymentTransactionRefNo;
  Null? paymentResponseText;
  Null? paymentMethod;
  Null? paymentAccount;
  Null? paymentDateTime;
  Null? updatedDateTime;
  Null? orderPaymentTransactionDetail;
  String? paymentProcessUrl;

  Data(
      {this.orderKeyId,
        this.orderAmount,
        this.orderId,
        this.orderStatus,
        this.orderPaymentStatus,
        this.orderPaymentStatusText,
        this.paymentStatus,
        this.paymentTransactionId,
        this.paymentResponseCode,
        this.paymentTransactionRefNo,
        this.paymentResponseText,
        this.paymentMethod,
        this.paymentAccount,
        this.paymentDateTime,
        this.updatedDateTime,
        this.orderPaymentTransactionDetail,
        this.paymentProcessUrl});

  Data.fromJson(Map<String, dynamic> json) {
    orderKeyId = json['OrderKeyId'];
    orderAmount = json['OrderAmount'];
    orderId = json['OrderId'];
    orderStatus = json['OrderStatus'];
    orderPaymentStatus = json['OrderPaymentStatus'];
    orderPaymentStatusText = json['OrderPaymentStatusText'];
    paymentStatus = json['PaymentStatus'];
    paymentTransactionId = json['PaymentTransactionId'];
    paymentResponseCode = json['PaymentResponseCode'];
    paymentTransactionRefNo = json['PaymentTransactionRefNo'];
    paymentResponseText = json['PaymentResponseText'];
    paymentMethod = json['PaymentMethod'];
    paymentAccount = json['PaymentAccount'];
    paymentDateTime = json['PaymentDateTime'];
    updatedDateTime = json['UpdatedDateTime'];
    orderPaymentTransactionDetail = json['OrderPaymentTransactionDetail'];
    paymentProcessUrl = json['PaymentProcessUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderKeyId'] = this.orderKeyId;
    data['OrderAmount'] = this.orderAmount;
    data['OrderId'] = this.orderId;
    data['OrderStatus'] = this.orderStatus;
    data['OrderPaymentStatus'] = this.orderPaymentStatus;
    data['OrderPaymentStatusText'] = this.orderPaymentStatusText;
    data['PaymentStatus'] = this.paymentStatus;
    data['PaymentTransactionId'] = this.paymentTransactionId;
    data['PaymentResponseCode'] = this.paymentResponseCode;
    data['PaymentTransactionRefNo'] = this.paymentTransactionRefNo;
    data['PaymentResponseText'] = this.paymentResponseText;
    data['PaymentMethod'] = this.paymentMethod;
    data['PaymentAccount'] = this.paymentAccount;
    data['PaymentDateTime'] = this.paymentDateTime;
    data['UpdatedDateTime'] = this.updatedDateTime;
    data['OrderPaymentTransactionDetail'] = this.orderPaymentTransactionDetail;
    data['PaymentProcessUrl'] = this.paymentProcessUrl;
    return data;
  }
}
