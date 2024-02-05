
import 'dart:convert';
import 'dart:io';
import 'package:booknplay/Screens/Profile/edit_profile.dart';
import 'package:booknplay/Screens/Profile/update_bank_details.dart';
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
import '../../Models/bankdetails_model.dart';
import '../../Utils/Colors.dart';
import '../../Widgets/app_button.dart';

class BankdetailsScreen extends StatefulWidget {

  @override
  State<BankdetailsScreen> createState() => _BankdetailsScreenState();
}

class _BankdetailsScreenState extends State<BankdetailsScreen> {
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
      banknameController.text =bankDetailsModel.data?.bankName ?? "" ;
      branchaddressController.text=bankDetailsModel.data?.branchAddress ?? "";
      acholdernameController.text=bankDetailsModel.data?.acHolderName ?? "";
      acnumberController.text=bankDetailsModel.data?.acNumber ?? "";
      ifsccodeController.text=bankDetailsModel.data?.ifscCode ?? "";
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
  @override
  void initState() {
    // TODO: implement initState
    getBankDetails();


    super.initState();

    referCode();
  }
  String? userId;
  referCode() async {
    userId = await SharedPre.getStringValue('userId');


  }


  bool isEditProfile = false ;

  TextEditingController banknameController = TextEditingController();
  TextEditingController branchaddressController = TextEditingController();
  TextEditingController acholdernameController = TextEditingController();
  TextEditingController acnumberController = TextEditingController();
  TextEditingController ifsccodeController = TextEditingController();






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
        title: Text("Bank Details",style: TextStyle(fontSize: 17),),
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


              SizedBox(height: 10,),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: banknameController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Bank Name"),
                        hintText: 'Bank Name'),

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
                    controller: branchaddressController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Branch Address"),
                        hintText: 'Branch Address'),

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
                    controller: acholdernameController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Ac Holder Name"),
                        hintText: 'Ac Holder Name'),

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
                    controller: acnumberController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Ac Number"),
                        hintText: 'Ac Number'),

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
                    controller: ifsccodeController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Ifs code"),
                        hintText: 'Ifs code'),

                  ),
                ),
              ),

              SizedBox(height: 20,),
              bankDetailsModel.data?.requestAdmin=="0"? AppButton(
                title: "Update Request",
                onTap: () async {
                  requestBankDetails();
                },
              ):bankDetailsModel.data?.requestAdmin=="1"?
              AppButton(
                title: "Wait For Approval",
                onTap: () async {
                //  await Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateBankdetailsScreen()));

                },
              ):
              AppButton(
                title: "Update Bank DEtails",
                onTap: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateBankdetailsScreen()));

                },
              )

            ],
          ),
        ),
      ) ,
    );
  }

  // updateProfile() async {
  //   setState(() {
  //     isEditProfile =  true;
  //   });
  //   Map<String,String> body={
  //     'user_name':nameController.text,
  //     'user_id':userId.toString(),
  //     "mobile":"${mobileController.text}"
  //   };
  //   final response = await
  //   http.post(Uri.parse('${baseUrl}apiProfileUpdate'), body:jsonEncode(body) );
  //
  //
  //   print('____request.fields______${body}_________');
  //
  //
  //   var data=  jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //
  //
  //     Fluttertoast.showToast(msg:"${data['msg']}" );
  //     setState(() {
  //       isEditProfile =  false;
  //     });
  //     Navigator.pop(context);
  //   }
  //   else {
  //     setState(() {
  //       isEditProfile =  false;
  //     });
  //     print(response.reasonPhrase);
  //   }
  //
  //
  // }
}
