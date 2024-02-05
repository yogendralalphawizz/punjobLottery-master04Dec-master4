
import 'dart:convert';
import 'dart:io';
import 'package:booknplay/Screens/Profile/edit_profile.dart';
import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:booknplay/Widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_profile_model.dart';
import '../../Models/all_deposit_balance.dart';
import '../../Models/bankdetails_model.dart';
import '../../Models/get_all_transaction_model.dart';
import '../../Models/referals_details_model.dart';
import '../../Utils/Colors.dart';
import '../../Widgets/app_button.dart';
import '../Auth_Views/Login/login_view.dart';
import '../Management/All_transaction_screen.dart';
import '../Management/deposit_history.dart';
import '../Withdrawal/withdrawal_view.dart';

class ViewProfileScreen extends StatefulWidget {
  ViewProfileScreen({Key? key,this.getProfileModel}) : super(key: key);
  final GetProfileModel? getProfileModel;

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  BankDetailsModel bankDetailsModel=BankDetailsModel();

  getBankDetails() async {

    Map<String,String> body={
      'user_id':"133"
      //await SharedPre.getStringValue('userId'),

    };
    print(body);
    final response = await
    http.post(Uri.parse('${baseUrl}api_GetBank_Details'),body: jsonEncode(body));

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      bankDetailsModel=BankDetailsModel.fromJson(data);

      setState(() {

      });


    }
    else {

      print(response.reasonPhrase);
    }


  }
  requestBankDetails() async {

    Map<String,String> body={
      'user_id':
      await SharedPre.getStringValue('userId'),

    };
    print(body);
    final response = await
    http.post(Uri.parse('${baseUrl}api_Bank_update_request_send'),body: jsonEncode(body));

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      Fluttertoast.showToast(msg:"${data["message"]}",backgroundColor: AppColors.fntClr );



    }
    else {

      print(response.reasonPhrase);
    }


  }
  blockMyid() async {

    Map<String,String> body={
      'user_id':
      await SharedPre.getStringValue('userId'),

    };
    print(body);
    final response = await
    http.post(Uri.parse('${baseUrl}api_block_users'),body: jsonEncode(body));

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      Fluttertoast.showToast(msg:"${data["msg"]}",backgroundColor: AppColors.fntClr );
      if(data["msg"]==true){
        await SharedPre.clear('userId');
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
        setState(()  {

          //Get.toNamed(loginScreen);
        });
      }



    }
    else {

      print(response.reasonPhrase);
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    nameController.text = widget.getProfileModel?.profile?.userName ?? "" ;
    mobileController.text = widget.getProfileModel?.profile?.mobile ?? "" ;
    referralcodeController.text=widget.getProfileModel?.profile?.referralCode??"";
    securitypinController.text=widget.getProfileModel?.profile?.securityPin??"";
    addressController.text=widget.getProfileModel?.profile?.address??"";
    adharnoController.text=widget.getProfileModel?.profile?.aadhaarNumber??"";
    pannoController.text=widget.getProfileModel?.profile?.panCard??"";
    txtidController.text=widget.getProfileModel?.profile?.transactionId??"";
    citypinController.text=widget.getProfileModel?.profile?.cityPin??"";
    // image = widget.getProfileModel?.profile?.image  ?? '';
    getWallettowallet();
    getbalance();
    getBankDetails();
    GetAllTransactionHistory();
    super.initState();

    referCode();
  }
  String? userId;
  String? selectoption;

  referCode() async {
    userId = await SharedPre.getStringValue('userId');


  }
  GetAllDepositBalanceModel getAllDepositBalanceModel=GetAllDepositBalanceModel();
  GetAllTransactionHistoryModel getAllTransactionHistoryModel=GetAllTransactionHistoryModel();
  getbalance() async {
    Map<String,String> body={
      'user_id': await SharedPre.getStringValue('userId'),

    };
    final response = await
    http.post(Uri.parse('${baseUrl}api_getAllDepositBalance'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      getAllDepositBalanceModel=GetAllDepositBalanceModel.fromJson(data);
      setState(() {

      });



    }
    else {

      print(response.reasonPhrase);
    }


  }
  GetAllTransactionHistory() async {
    Map<String,String> body={
      'user_id': await SharedPre.getStringValue('userId'),
      //await SharedPre.getStringValue('userId'),

    };
    final response = await
    http.post(Uri.parse('${baseUrl}api_AllTransactionHistory'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      getAllTransactionHistoryModel=GetAllTransactionHistoryModel.fromJson(data);
      setState(() {

      });



    }
    else {

      print(response.reasonPhrase);
    }


  }
  ClearData(String type) async {
    Map<String,String> body={
      'user_id': await SharedPre.getStringValue('userId'),
      "type":type

      //await SharedPre.getStringValue('userId'),

    };
    final response = await
    http.post(Uri.parse('${baseUrl}api_DeleteTransactionHistory'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg:"${data["msg"]}",backgroundColor: AppColors.fntClr );


      setState(() {

      });



    }
    else {

      print(response.reasonPhrase);
    }


  }


  bool isEditProfile = false ;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController referralcodeController = TextEditingController();
  TextEditingController securitypinController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController adharnoController = TextEditingController();
  TextEditingController pannoController = TextEditingController();
  TextEditingController txtidController = TextEditingController();
  TextEditingController citypinController = TextEditingController();

  ReferalsDetailsModel referalsDetailsModel=ReferalsDetailsModel();
  getWallettowallet() async {
    Map<String,String> body={
      'user_id':
      await SharedPre.getStringValue('userId'),

    };
    final response = await
    http.post(Uri.parse('${baseUrl}api_GetMyTeamDetails'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      referalsDetailsModel=ReferalsDetailsModel.fromJson(data);
      setState(() {

      });



    }
    else {

      print(response.reasonPhrase);
    }


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whit,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        //automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.only(
            bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
          ),),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text("View Profile",style: TextStyle(fontSize: 17),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius:   BorderRadius.only(
              bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [


              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network("${widget.getProfileModel?.profile?.image??""}",height:100,width:100,fit: BoxFit.cover,),
              ),

              SizedBox(height: 10,),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Name"),
                        hintText: 'Enter Name'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // readOnly: true,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: mobileController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Mobile"),
                        hintText: 'Enter Mobile'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: referralcodeController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Referal Code"),
                        hintText: 'Enter Referal Code'),

                  ),
                ),
              ),
              // Container(
              //   height: 60,
              //   child: Padding(
              //
              //     padding: const EdgeInsets.all(8.0),
              //     child: TextFormField(
              //       readOnly: true,
              //       keyboardType: TextInputType.number,
              //       controller: securitypinController,
              //       decoration: const InputDecoration(
              //           contentPadding: EdgeInsets.only(top: 5,left: 10),
              //           border: OutlineInputBorder(),
              //           label: Text("Security Pin"),
              //           hintText: 'Enter Security Pin'),
              //
              //     ),
              //   ),
              // ),
              Container(
                height: 60,
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: addressController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Address"),
                        hintText: 'Enter Address'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: adharnoController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Adhar No."),
                        hintText: 'Enter Adhar No.'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: pannoController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Pan No."),
                        hintText: 'Enter Pan no.'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: txtidController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Enter transaction id"),
                        hintText: 'Enter transaction id'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: citypinController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("pin code"),
                        hintText: 'Enter pin code'),

                  ),
                ),
              ),
              SizedBox(height: 20,),
              AppButton(
                title: "Edit Profile",
                onTap: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen(getProfileModel: widget.getProfileModel,)));

                },
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                    color: AppColors.whit,
                    border: Border.all(color: AppColors.fntClr),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Text("Support Team",style: TextStyle(
                        color: AppColors.fntClr,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 20,),
                   bankDetailsModel.data?.requestAdmin=="1"? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Text("Bank Account Change Request"),


                          ],
                        ),

                      ],
                    ):SizedBox.shrink(),
                    SizedBox(
                      height: 10,
                    ),
                    bankDetailsModel.data?.requestAdmin=="2" ?  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text("Set Your New  Account"),


                          ],
                        ),
                      ],
                    ):SizedBox.shrink(),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){
                        requestBankDetails();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColors.whit,
                            border: Border.all(color: AppColors.fntClr),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Bank Chnage Request",style: TextStyle(
                              color:AppColors.fntClr,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){
                        blockMyid();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColors.whit,
                            border: Border.all(color: AppColors.fntClr),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Block My Id",style: TextStyle(
                              color:AppColors.fntClr,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                    color: AppColors.whit,
                    border: Border.all(color: AppColors.fntClr),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Text("Wallet History",style: TextStyle(
                      color: AppColors.fntClr,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.whit,
                                border: Border.all(color: AppColors.fntClr),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: Text("Deposit",style: TextStyle(
                                      color:AppColors.fntClr,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),

                                Divider(indent: 20,endIndent: 20,thickness: 2,color: AppColors.fntClr,),
                                SizedBox(
                                  height: 10,
                                ),
                                Material(
                                  color: AppColors.whit,
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.whit,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Rs.${referalsDetailsModel.data?.depositAmount??"0"}/-",style: TextStyle(
                                          color:AppColors.fntClr,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.whit,
                                border: Border.all(color: AppColors.fntClr),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: Text("Withdrawal",style: TextStyle(
                                      color:AppColors.fntClr,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),

                                Divider(indent: 20,endIndent: 20,thickness: 2,color: AppColors.fntClr,),
                                SizedBox(
                                  height: 10,
                                ),
                                Material(
                                  color: AppColors.whit,
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.whit,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Rs.${referalsDetailsModel.data?.withdrawalAmount??"0"}/-",style: TextStyle(
                                          color:AppColors.fntClr,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.whit,
                                border: Border.all(color: AppColors.fntClr),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: Text("Other Balance",style: TextStyle(
                                      color:AppColors.fntClr,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),

                                Divider(indent: 20,endIndent: 20,thickness: 2,color: AppColors.fntClr,),
                                SizedBox(
                                  height: 10,
                                ),
                                Material(
                                  elevation: 2,
                                    color: AppColors.whit,
                                    borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.whit,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Rs.${referalsDetailsModel.data?.refferalAmount??"0"}/-",style: TextStyle(
                                          color:AppColors.fntClr,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                    color: AppColors.whit,
                    border: Border.all(color: AppColors.fntClr),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Text("All TRANSCATION REPORT",style: TextStyle(
                        color: AppColors.fntClr,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        Expanded(

                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return DepositHistoryScreen(getAllDepositBalanceModel: getAllDepositBalanceModel,);
                              }));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.whit,
                                  border: Border.all(color: AppColors.fntClr),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text("Deposit",style: TextStyle(
                                        color:AppColors.fntClr,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return WithdrawalScreen(index: 2,);
                              }));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.whit,
                                  border: Border.all(color: AppColors.fntClr),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Text("Withdrawal",style: TextStyle(
                                    color:AppColors.fntClr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return AllTransactionHistoryScreen(getAllTransactionHistoryModel: getAllTransactionHistoryModel,);
                              }));
                            },
                            child: Container(
                               padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.whit,
                                  border: Border.all(color: AppColors.fntClr),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Text("All Report",style: TextStyle(
                                    color:AppColors.fntClr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:   Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: AppColors.whit,
                                border: Border.all(color: AppColors.fntClr),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: DropdownButton<dynamic>(
                              hint: Text("Select Option",style: TextStyle(color: Colors.black87,fontSize: 12),),
                              value: selectoption,
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.fntClr,
                              ),
                              items: ["Deposit","Withdrawal","All Report"].map(( value) {
                                return DropdownMenuItem<dynamic>(
                                  value: value,
                                  child: Text(value??""),
                                );
                              }).toList(),
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: ( value) async {
                                setState(() {
                                  selectoption = value;

                                });

                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              if(selectoption==null){
                                Fluttertoast.showToast(msg:"Please Select Option",backgroundColor: AppColors.fntClr );
                                return;
                              }
                              ClearData(selectoption=="Deposit"?"1":selectoption=="Withdrawal"?"2":selectoption=="All Report"?"3":"");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: AppColors.whit,
                                  border: Border.all(color: AppColors.fntClr),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text("Clear Data",style: TextStyle(
                                    color:AppColors.fntClr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ],

          ),
        ),
      ) ,
    );
  }

  updateProfile() async {
    setState(() {
      isEditProfile =  true;
    });
    Map<String,String> body={
      'user_name':nameController.text,
      'user_id':userId.toString(),
      "mobile":"${mobileController.text}"
    };
    final response = await
    http.post(Uri.parse('${baseUrl}apiProfileUpdate'), body:jsonEncode(body) );


    print('____request.fields______${body}_________');


    var data=  jsonDecode(response.body);
    if (response.statusCode == 200) {


      Fluttertoast.showToast(msg:"${data['msg']}" );
      setState(() {
        isEditProfile =  false;
      });
      Navigator.pop(context);
    }
    else {
      setState(() {
        isEditProfile =  false;
      });
      print(response.reasonPhrase);
    }


  }
}
