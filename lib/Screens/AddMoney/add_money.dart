import 'dart:convert';
import 'dart:io';


import 'package:booknplay/Screens/AddMoney/payment_getway.dart';
import 'package:booknplay/Utils/Colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart'as http;

import 'dart:ui' as ui;


import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/wallet_blanced_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/button.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key, }) : super(key: key);

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  // @override
  // void initState() {
  //   super.initState();
  //   _razorpay = Razorpay();
  //   _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  // }
  // Razorpay? _razorpay;
  // int? priceRazorpay;
  // String id = '';
  // void openCheckout(amount) async {
  //   double res = double.parse(amount.toString());
  //   priceRazorpay= int.parse(res.toStringAsFixed(0)) * 100;
  //   debugPrint("checking razorpay price ${priceRazorpay.toString()}");
  //   // Navigator.of(context).pop();
  //   var options = {
  //     'key': 'rzp_test_1DP5mmOlF5G5ag',
  //     'amount': "${priceRazorpay}",
  //     'name': 'Dr.Apps',
  //     'image':'assets/splash/splashimages.png',
  //     'description': 'PunjabLottery',
  //   };
  //   try {
  //     _razorpay?.open(options);
  //   } catch (e) {
  //     debugPrint('Error: e');
  //   }
  // }
  // Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   Fluttertoast.showToast(msg: "Subscription added successfully");
  //   // getplanPurchaseSuccessApi();
  //
  // }
  // void _handlePaymentError(PaymentFailureResponse response) {
  //   Fluttertoast.showToast(msg: "Payment cancelled by user");
  //   // setSnackbar("ERROR", context);
  //   // setSnackbar("Payment cancelled by user", context);
  // }
  // void _handleExternalWallet(ExternalWalletResponse response) {
  // }
  bool isAddmoney=false;
  String ?min;
  String ?max;
  sucessPayment() async {
    Map<String,String> body={
    'user_id':await SharedPre.getStringValue('userId'),
    'amount':amtC.text,
    "txn_id":"test",
    "txn_ref":"asfdasf"
  };
    final response = await
    http.post(Uri.parse('${baseUrl}apiAddMoneyViaUpi'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    if (response.statusCode == 200) {


      Fluttertoast.showToast(msg:"${data['msg']}" );
      setState(() {
        isAddmoney =  false;
      });
      getWalletblance();
      Navigator.pop(context);
    }
    else {
      setState(() {
        isAddmoney =  false;
      });
      print(response.reasonPhrase);
    }

    print('____request.fields______${body}_________');
  }
  checkvalidateAmount() async {
    Map<String,String> body={

      'amount':"100",

    };
    final response = await
    http.post(Uri.parse('${baseUrl}apivalidatePaymentAmount'), body:jsonEncode(body) );
    print("${response.body}_________________-");
    var data=  jsonDecode(response.body);
    if (response.statusCode == 200) {
     min=data["data"]["min"];
     max=data["data"]["max"];



      setState(() {

      });

    }


    print('____request.fields______${body}_________');
  }
  WalletModel walletModel=WalletModel();
  PAYMENTSUCESSMODEL paymentsucessmodel=PAYMENTSUCESSMODEL();

  sucessPayment1() async {
    Map<String,String> body={
    //  'order_id':"${widget.orderid}",
      'amount':"${amtC.text}",
      // "txn_id":"test",
      // "txn_ref":"asfdasf"
    };
    final response = await
    http.post(Uri.parse('https://cleverpager.in/Apicontroller/add_wallet'), body:body );
    var data=  jsonDecode(response.body);

    if (response.statusCode == 200) {

      paymentsucessmodel=PAYMENTSUCESSMODEL.fromJson(data);
      Fluttertoast.showToast(msg:"${data['mess']}" );
      // setState(() {
      //   isAddmoney =  false;
      // });
      // getWalletblance();

    }
    else {
      // setState(() {
      //   isAddmoney =  false;
      // });
      print(response.reasonPhrase);
    }

    print('____request.fields______${body}_________');
  }
  getWalletblance() async {
    Map<String,String> body={
      'user_id':await SharedPre.getStringValue('userId'),

    };
    final response = await
    http.post(Uri.parse('${baseUrl}wallet_balance'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

       walletModel=WalletModel.fromJson(data);
       setState(() {

       });



    }
    else {

      print(response.reasonPhrase);
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    checkvalidateAmount();
    getWalletblance();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          backgroundColor: AppColors.primary,

          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
            ),),
          toolbarHeight: 60,
          centerTitle: true,
          title: Text("Wallet",style: TextStyle(fontSize: 17),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius:   BorderRadius.only(
                bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

            ),
          ),
        ),
        body: Column(
           children: [
             showContent()
           ],
        )
    );
  }
  StateSetter? dialogState;
  final _formKey = GlobalKey<FormState>();
  TextEditingController  amtC = TextEditingController();
  TextEditingController  msgC = TextEditingController();
  ScrollController controller = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  showContent() {
    return SingleChildScrollView(
      controller: controller,
      child:  Column(
          mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: AppColors.primary,
                      ),
                      Text(
                        " " + 'Current Balance',
                        style: TextStyle(color: AppColors.fntClr,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text("₹ ${walletModel.data?.walletBalance??"0"}" ),
                  SizedBox(height: 10,),

                  AppButton(
                    isloading: isAddmoney,
                    onTap: (){
                      setState(() {
                        isAddmoney=true;
                      });
                      _showDialog();
                 //   Get.to(()=>  Paymentgetway());
                    },

                    title: "Add Money",
                  )
                ],
              ),
            ),
          ),
        ),

      ]),
    );
  }
  _showDialog() async {
    bool payWarn = false;
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
          dialogState = setStater;
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                    child: Text( "Add Money",
                      style: TextStyle(color: AppColors.fntClr),
                    ),
                  ),
                  // Divider(color: Theme.of(context).colorScheme.lightBlack),
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
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      style: const TextStyle(
                                        color: AppColors.fntClr,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Amount',
                                        hintStyle: TextStyle(color: AppColors.primary,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      controller: amtC,
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                    child: TextFormField(
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      style: const TextStyle(
                                        color: AppColors.activeBorder,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "Message",
                                        hintStyle: TextStyle(color: AppColors.primary,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      controller: msgC,
                                    )),
                                //Divider(),
                                // Padding(
                                //   padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                                //   child: Text(
                                //     "Select Payment Method",
                                //     style: Theme.of(context).textTheme.subtitle2,
                                //   ),
                                // ),
                                Divider(),

                              ])),
                    ),
                  )
                ]),
            actions: <Widget>[
              TextButton(
                  child: Text(
                    'Cancel',
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: AppColors.fntClr,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text(
                    'Send',
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: AppColors.fntClr,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if(amtC.text.isEmpty){
                      Fluttertoast.showToast(msg:"Please enter amount",backgroundColor: AppColors.primary );
                      setState(() {
                        isAddmoney=false;
                      });
                      return ;

                    }
                    if(int.parse(min.toString())>int.parse(amtC.text)){
                      Fluttertoast.showToast(msg:"Please enter amount avobe ${min}",backgroundColor: AppColors.primary );
                      setState(() {
                        isAddmoney=false;
                      });
                      return ;
                    }
                    if(int.parse(max.toString())<int.parse(amtC.text)){
                      Fluttertoast.showToast(msg:"Please enter amount low ${max}",backgroundColor: AppColors.primary );
                      setState(() {
                        isAddmoney=false;
                      });
                      return ;
                    }

                    else {
                     await sucessPayment1();
                     Get.off(()=>Paymentgetway(amount: "${amtC.text}", orderid: "", url: "${paymentsucessmodel.data?.paymentProcessUrl}"))?.then((value) {

                       isAddmoney=false;
                       getWalletblance();

                     });
                    }
                   })
               ],
            );
        }));
  }
  dialogAnimate(BuildContext context, Widget dialog) {
    return showGeneralDialog(
        barrierColor: AppColors.fntClr,
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
        // pageBuilder: null
        pageBuilder: (context, animation1, animation2) {
          return Container();
        } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
    );
  }
}
