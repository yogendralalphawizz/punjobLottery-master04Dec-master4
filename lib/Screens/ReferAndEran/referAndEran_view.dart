import 'dart:convert';
import 'dart:io';

import 'package:booknplay/Constants.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Auth_Views/Signup/signup_view.dart';
import 'package:booknplay/Screens/Profile/profile_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/custom_clip_path.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart'as http;
import 'package:share/share.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/active_business_model.dart';
import '../../Models/HomeModel/get_profile_model.dart';
import '../../Models/HomeModel/wallet_blanced_model.dart';
import '../../Models/active_business_model.dart';
import '../../Models/deposit_active_and_non_deposit_model.dart';
import '../../Models/list_rols.dart';
import '../../Models/referals_details_model.dart';
import '../../Models/withdrawal_model.dart';
import '../../Services/api_services/apiConstants.dart';

class ReferAndEran extends StatefulWidget {
  final GetProfileModel? getProfileModel;
  const ReferAndEran({this.getProfileModel }) ;

  @override
  State<ReferAndEran> createState() => _ReferAndEranState();
}

class _ReferAndEranState extends State<ReferAndEran> {
  @override
   initState() {
    // TODO: implement initState
    super.initState();
    getWallettowallet();
    getMobile();
    getActivebusiness1();
    getActiveBusiness();
    getdepositcountandnondeposit();
    getWalletblance();
    getWithdrawalblance();
  }

  String? mobile,userReferCode;
  DepositTeamModel depositTeamModel=DepositTeamModel();
  getMobile() async {
     mobile =  await SharedPre.getStringValue('userMobile');
     userReferCode = await SharedPre.getStringValue('userReferCode');
     setState(() {

     });
  }
  ReferalsDetailsModel referalsDetailsModel=ReferalsDetailsModel();
  RolesListModel rolesListModel=RolesListModel();
  ActiveBusinessModel activeBusinessModel=ActiveBusinessModel();
  getWallettowallet() async {
    Map<String,String> body={
      'user_id':
      await SharedPre.getStringValue('userId'),

    };
    final response = await
    http.post(Uri.parse('${baseUrl}api_GetMyTeamDetails'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    print(data.toString()+"+++++++++++++++++++++++++++");
    if (response.statusCode == 200) {

      referalsDetailsModel=ReferalsDetailsModel.fromJson(data);
      setState(() {

      });



    }
    else {

      print(response.reasonPhrase);
    }


  }
  getdepositcountandnondeposit() async {
    Map<String,String> body={
      'user_id':
      await SharedPre.getStringValue('userId'),

    };
    final response = await
    http.post(Uri.parse('${baseUrl}api_referral_deposit_count1'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      depositTeamModel=DepositTeamModel.fromJson(data);
      setState(() {

      });



    }
    else {

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
    final response = await
    http.post(Uri.parse('${baseUrl}api_ListofRoles'));

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      rolesListModel=RolesListModel.fromJson(data);
      setState(() {

      });


    }
    else {

      print(response.reasonPhrase);
    }


  }
  ActiveBusinessModel1 activeBusinessModel1=ActiveBusinessModel1();
  getActivebusiness1() async {

    Map<String,String> body={
      'user_id':await SharedPre.getStringValue('userId'),

    };
    //  print(body);
    final response = await
    http.post(Uri.parse('${baseUrl}api_get_mapping'),body: jsonEncode(body));

    var data=  jsonDecode(response.body);
    print(data.toString()+"***************8");
    if (response.statusCode == 200) {

      activeBusinessModel1=ActiveBusinessModel1.fromJson(data);
      setState(() {

      });


    }
    else {

      print(response.reasonPhrase);
    }


  }
  getActiveBusiness() async {

    Map<String,String> body={
      'user_id':await SharedPre.getStringValue('userId'),

    };
     print(body);
    final response = await
    http.post(Uri.parse('${baseUrl}api_ListofRoles'),body: jsonEncode(body));

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      activeBusinessModel=ActiveBusinessModel.fromJson(data);
      setState(() {

      });


    }
    else {

      print(response.reasonPhrase);
    }


  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Container(
        height: 400,
          width: double.infinity,

          child: Column(
            children: [
              Text("Refferal Team"),
              referalsDetailsModel.data?.refferalData?.isNotEmpty??false?
              ListView.builder(
                shrinkWrap: true,
                  itemCount: referalsDetailsModel.data?.refferalData?.length??0,
                  itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    title: Text("Name: ${referalsDetailsModel.data?.refferalData?[index].userName??""}"),
                    subtitle: Text("Mobile: ${referalsDetailsModel.data?.refferalData?[index].mobile??""}"),
                  ),
                );
              }):Expanded(
                child: Center(
                  child: Text("No Data Found",style: TextStyle(fontSize: 10),),
                ),
              )
            ],
          )

      ),
     // content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertDialog2(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Container(
          height: 400,
          width: double.infinity,

          child: Column(
            children: [
              Text("Deposit Team"),
              depositTeamModel.data?.depositActiveData?.isNotEmpty??false?
              ListView.builder(
                  shrinkWrap: true,
                  itemCount:  depositTeamModel.data?.depositActiveData?.length??0,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text("Name: ${depositTeamModel.data?.depositActiveData?[index].userName??""}"),
                        subtitle: Text("email: ${depositTeamModel.data?.depositActiveData?[index].email??""}"),
                      ),
                    );
                  }):Expanded(
                child: Center(
                  child: Text("No Data Found",style: TextStyle(fontSize: 10),),
                ),
              )
            ],
          )

      ),
      // content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertDialog3(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Container(
          height: 400,
          width: double.infinity,

          child: Column(
            children: [
              Text("Non Deposit Team"),
              depositTeamModel.data?.depositDeactiveData?.isNotEmpty??false==0?
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: depositTeamModel.data?.depositDeactiveData?.length??0,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text("Name: ${depositTeamModel.data?.depositDeactiveData?[index].userName??""}"),
                        subtitle: Text("email: ${depositTeamModel.data?.depositDeactiveData?[index].email??""}"),
                      ),
                    );
                  }):Expanded(
                child: Center(
                  child: Text("No Data Found",style: TextStyle(fontSize: 10),),
                ),
              )
            ],
          )

      ),
      // content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  TextEditingController controller = TextEditingController();

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
        title: Text("Refer & Earn",style: TextStyle(fontSize: 17),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius:   BorderRadius.only(
              bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

          ),
        ),
      ),
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(

              children: [
                SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Refferal Income",style: TextStyle(
                            color:AppColors.fntClr,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                                  SizedBox(height: 10,),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                    decoration: BoxDecoration(
                                                        color: AppColors.whit,
                                                        border: Border.all(color: AppColors.fntClr),
                                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Text("${referalsDetailsModel.data?.refferalAmount??"0"}",
                                                            style: TextStyle(
                                                              color:AppColors.fntClr,
                                                              fontSize: 16,
                                                               fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                          SizedBox(height: 5,),
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 3),

                                                            decoration: BoxDecoration(
                                                              color: AppColors.primary,
                                                              borderRadius: BorderRadius.circular(3)
                                                            ),
                                                            child: Text("Active",
                                                              style: TextStyle(
                                                                color:AppColors.whit,
                                                                fontSize: 14,
                                                                // fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                    ),)
                      ],
                    ),
                  ),
                    SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Refferal Team",style: TextStyle(
                            color:AppColors.fntClr,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                          decoration: BoxDecoration(
                              color: AppColors.whit,
                              border: Border.all(color: AppColors.fntClr),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Text("${referalsDetailsModel.data?.refferalCount??"0"}",
                                  style: TextStyle(
                                      color:AppColors.fntClr,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 5,),
                                InkWell(
                                  onTap: (){
                                    showAlertDialog(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 3),

                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Text("View",
                                      style: TextStyle(
                                        color:AppColors.whit,
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),)
                      ],
                    ),
                  )
                ],
              ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 2),
                  decoration: BoxDecoration(

                    border: Border.all(color: AppColors.fntClr),
                    borderRadius: BorderRadius.circular(5),

                  ),
                  child: Column(
                    children: [

                      Container(
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 2),
                          decoration: BoxDecoration(

                            border: Border.all(color: AppColors.fntClr),
                            borderRadius: BorderRadius.circular(5),

                          ),
                          child: Center(child: Text("Active Business Income",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold,fontSize: 18),))),
                      SizedBox(height: 10,),
                                   Row(
                                     children: [
                       Expanded(
                         flex: 3,
                         child: Container(
                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                           decoration: BoxDecoration(
                             color: AppColors.primary,
                             borderRadius: BorderRadius.circular(5),

                           ),
                           child: Center(child: Text("Deposit Recharge",style: TextStyle(color: AppColors.whit,fontSize: 16))),
                         ),
                       ),
                       SizedBox(width: 5,),
                       Expanded(
                         child: Container(
                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                           decoration: BoxDecoration(
                             color: AppColors.primary,
                             borderRadius: BorderRadius.circular(5),

                           ),
                           child: Center(child: Text("${activeBusinessModel1.data?.depositCount??"0"}",style: TextStyle(color: AppColors.whit,fontSize: 13))),
                         ),
                       ),
                       SizedBox(width: 5,),
                       Expanded(
                         flex: 2,
                         child: Container(
                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                           decoration: BoxDecoration(
                             color: AppColors.primary,
                             borderRadius: BorderRadius.circular(5),

                           ),
                           child: Center(child: Text("${activeBusinessModel1.data?.deposit??"deactive"}",style: TextStyle(color: AppColors.whit,fontSize: 16))),
                         ),
                       )

                                     ],
                                   ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5),

                              ),
                              child: Center(child: Text("Withdrawal",style: TextStyle(color: AppColors.whit,fontSize: 16))),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5),

                              ),
                              child: Center(child: Text("${activeBusinessModel1.data?.withdrawalCount??"0"}",style: TextStyle(color: AppColors.whit,fontSize: 13))),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5),

                              ),
                              child: Center(child: Text("${activeBusinessModel1.data?.withdrawal??"deactive"}",style: TextStyle(color: AppColors.whit,fontSize: 16))),
                            ),
                          )

                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                HtmlWidget(
                  '''
           ${rolesListModel.data?.refferalRole??""}
            ''',
                ),
                SizedBox(height: 10,),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 2),
                  decoration: BoxDecoration(

                    border: Border.all(color: AppColors.fntClr),
                    borderRadius: BorderRadius.circular(5),

                  ),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 2),
                          decoration: BoxDecoration(

                            border: Border.all(color: AppColors.fntClr),
                            borderRadius: BorderRadius.circular(5),

                          ),
                          child: Center(child: Text("Refferal Link",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold,fontSize: 18),))),
                      SizedBox(height: 10,),

                      Container(

                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        decoration: BoxDecoration(

                          border: Border.all(color: AppColors.fntClr),
                          borderRadius: BorderRadius.circular(5),

                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.whit,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: AppColors.fntClr)
                              ),
                              child: Center(child: Text("https://cleverpager.in/${widget.getProfileModel?.profile?.referralCode}",style: TextStyle(color: AppColors.fntClr,fontSize: 16),)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      Clipboard.setData(new ClipboardData(text: "${widget.getProfileModel?.profile?.referralCode}"))
                                          .then((_) {
                                        controller.clear();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Copied to your clipboard !')));
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          color: AppColors.whit,
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: AppColors.fntClr)
                                      ),
                                      child: Center(child: Text("Link Copy",style: TextStyle(color: AppColors.fntClr,fontSize: 16),)),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      Share.share('check out my APP "https://cleverpager.in/${widget.getProfileModel?.profile?.referralCode}"');
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          color: AppColors.whit,
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: AppColors.fntClr)
                                      ),
                                      child: Center(child: Text("Share Link",style: TextStyle(color: AppColors.fntClr,fontSize: 16),)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                await SharedPre.clear('userId');
                                await Future.delayed(const Duration(milliseconds: 500));
                                Get.offAll(()=>SignupScreen(referalcode: "${widget.getProfileModel?.profile?.referralCode}",));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(
                                    color: AppColors.whit,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: AppColors.fntClr)
                                ),
                                child: Center(child: Text("Swith To Registration Page",style: TextStyle(color: AppColors.fntClr,fontSize: 16),)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
                SizedBox(height: 10,),


               Container(
                 padding: EdgeInsets.symmetric(vertical: 10,horizontal: 2),
                 decoration: BoxDecoration(

                   border: Border.all(color: AppColors.fntClr),
                   borderRadius: BorderRadius.circular(5),

                 ),
                 child: Column(
                   children: [
                     Container(
                         padding: EdgeInsets.symmetric(vertical: 10,horizontal: 2),
                         decoration: BoxDecoration(

                           border: Border.all(color: AppColors.fntClr),
                           borderRadius: BorderRadius.circular(5),

                         ),
                         child: Center(child: Text("My Team Details",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold,fontSize: 18),))),
                     SizedBox(height: 10,),
                     Row(
                       children: [
                         Expanded(
                           flex: 2,
                           child: InkWell(
                             onTap: (){
                               showAlertDialog2(context);
                             },
                             child: Container(
                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                               decoration: BoxDecoration(
                                 color: AppColors.primary,
                                 borderRadius: BorderRadius.circular(5),

                               ),
                               child:  Center(child: Text("Deposit Team(${depositTeamModel.data?.depositActive??"0"})",style: TextStyle(color: AppColors.whit,fontSize: 14))),
                             ),
                           ),
                         ),
                         SizedBox(width: 10,),
                         Expanded(
                           flex: 2,
                           child: InkWell(
                             onTap: (){
                               showAlertDialog3(context);
                             },
                             child: Container(
                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                               decoration: BoxDecoration(
                                 color: AppColors.primary,
                                 borderRadius: BorderRadius.circular(5),

                               ),
                               child: Center(child: Text("Non Deposit Team(${depositTeamModel.data?.depositDeactive??"0"})",style: TextStyle(color: AppColors.whit,fontSize: 13))),
                             ),
                           ),
                         )
                       ],
                     )
                     ,
                      SizedBox(height: 10,),
                      Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                       height: 220,
                        decoration: BoxDecoration(

                          border: Border.all(color: AppColors.fntClr),
                          borderRadius: BorderRadius.circular(5),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network("${widget.getProfileModel?.profile?.image??""}",height: 100,width:100,fit: BoxFit.cover,),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 120,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                          decoration: BoxDecoration(
                                              color: AppColors.whit,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: AppColors.fntClr)
                                          ),
                                          child: Center(child: Text("Name: ${widget.getProfileModel?.profile?.userName}",style: TextStyle(color: AppColors.fntClr,fontSize: 12),)),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: AppColors.whit,
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(color: AppColors.fntClr)
                                                ),
                                                child: Center(child: Text("Mobile: ${widget.getProfileModel?.profile?.mobile}",style: TextStyle(color: AppColors.fntClr,fontSize: 12),)),
                                              ),
                                            ),

                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                          decoration: BoxDecoration(
                                              color: AppColors.whit,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: AppColors.fntClr)
                                          ),
                                          child: Center(child: Text("Refferal Code: ${widget.getProfileModel?.profile?.referralCode}",style: TextStyle(color: AppColors.fntClr,fontSize: 12),)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.whit,
                                        border: Border.all(color: AppColors.fntClr),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text("Total Deposit",
                                            style: TextStyle(
                                                color:AppColors.fntClr,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Text("Rs. ${referalsDetailsModel.data?.depositAmount??"0"}/-",
                                            style: TextStyle(
                                              color:AppColors.primary,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.whit,
                                        border: Border.all(color: AppColors.fntClr),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text("Total Income",
                                            style: TextStyle(
                                                color:AppColors.fntClr,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Text("Rs. ${referalsDetailsModel.data?.withdrawalAmount??"0"}/-",
                                            style: TextStyle(
                                                color:AppColors.primary,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                   ],
                 ),
               ),







                SizedBox(height: 50,)



                // Padding(
                //   padding: const EdgeInsets.only(top: 28.0),
                //   child: Text(
                //     "Refer And Earn",
                //     style: Theme.of(context).textTheme.headline5!.copyWith(
                //         color: AppColors.fntClr),
                //   ),
                // ),
                // const Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Text(
                //     "Invite your friends to join and get the reward as soon as your friend first order placed",
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // const Padding(
                //   padding: EdgeInsets.only(top: 28.0),
                //   child: Text(
                //    "Your Referral Code",
                //     style: TextStyle(color: AppColors.fntClr),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     decoration:  BoxDecoration(
                //       border: Border.all(
                //         width: 1,
                //         style: BorderStyle.solid,
                //         color: AppColors.fntClr,
                //       ),
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //     child:  Padding(
                //       padding: EdgeInsets.all(8.0),
                //       child: Text(
                //         "${widget.getProfileModel?.profile?.referralCode}",
                //         style: TextStyle(color: AppColors.fntClr),
                //       ),
                //     ),
                //   ),
                // ),
                // CupertinoButton(
                //   padding: EdgeInsets.zero,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                //     decoration: BoxDecoration(
                //         color: AppColors.activeBorder,
                //         borderRadius:
                //         new BorderRadius.all(const Radius.circular(4.0))),
                //     child: Text("Tap to copy",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(color: AppColors.whit),
                //       ),),
                //   onPressed: () {
                //     Clipboard.setData(new ClipboardData(text: "$userReferCode"));
                //     // setSnackbar('Refercode Copied to clipboard');
                //     Fluttertoast.showToast(msg: 'Refercode Copied to clipboard',
                //         backgroundColor: AppColors.primary
                //     );
                //   },
                // ),
                // SizedBox(height: 10),
                // AppButton(
                //   onTap: () {
              //        var str =
              // "$appName\nRefer Code:$""\n${getTranslated(context, 'APPFIND')}$androidLink$packageName\n\n${getTranslated(context, 'IOSLBL')}\n$iosLink$iosPackage";
              //       Share.share(mobile ?? "");
              //        share(referCode: userReferCode);
                //
                //   },
                //   title: "Share",
                // )
                // SimBtn(
                //   size: 0.8,
                //   title: "Share",
                //   onBtnSelected: () {
                //     var str =
                //         "$appName\nRefer Code:$"REFER_CODE"\n${getTranslated(context, 'APPFIND')}$androidLink$packageName\n\n${getTranslated(context, 'IOSLBL')}\n$iosLink$iosPackage";
                //     Share.share(str);
                //   },
                // ),
              ],
            ),
          ),
        ),
    );
  }
  GlobalKey keyList = GlobalKey() ;
  bool iconVisible = true;
  Future<void> share({String? referCode}) async {

    await FlutterShare.share(
        title: 'Refer and Eran',
        text: '$referCode',
        linkUrl: 'Refer and Eran',
        chooserTitle: 'Example Chooser Title'
    );
  }

}
