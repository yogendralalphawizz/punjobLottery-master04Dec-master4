
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../../Local_Storage/shared_pre.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Utils/Colors.dart';
import '../../Widgets/app_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController password = TextEditingController();
  TextEditingController cfpassword = TextEditingController();
  TextEditingController oldpassword = TextEditingController();
  requestBankDetails() async {

    Map<String,String> body={
      'user_id':
      await SharedPre.getStringValue('userId'),
      "old_pass":"${oldpassword.text}",
      "password":"${password.text}"


    };
    print(body);
    final response = await
    http.post(Uri.parse('${baseUrl}apiChangePassword'),body: jsonEncode(body));

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      Fluttertoast.showToast(msg:"${data["msg"]}",backgroundColor: AppColors.fntClr );



    }
    else {

      print(response.reasonPhrase);
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        //automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.only(
            bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
          ),),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text("Change Password",style: TextStyle(fontSize: 17),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius:   BorderRadius.only(
              bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              child: Padding(

                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: oldpassword,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,left: 10),
                      border: OutlineInputBorder(),
                      label: Text("Old Password"),
                      hintText: 'Old Password'),

                ),
              ),
            ),


            Container(
              height: 60,
              child: Padding(

                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: password,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,left: 10),
                      border: OutlineInputBorder(),
                      label: Text("New Password"),
                      hintText: 'New Password'),

                ),
              ),
            ),

            Container(
              height: 60,
              child: Padding(

                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: cfpassword,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,left: 10),
                      border: OutlineInputBorder(),
                      label: Text("Confirm Password"),
                      hintText: 'Confirm Password'),

                ),
              ),
            ),
            SizedBox(height: 20,),
            AppButton(
              title: "Change Password",
              onTap: () async {
                if(password.text==""){
                  Fluttertoast.showToast(msg:"Please fill Password ",backgroundColor: AppColors.fntClr );
                  return;
                }
                if(oldpassword.text==""){
                  Fluttertoast.showToast(msg:"Please fill old Password ",backgroundColor: AppColors.fntClr );
                  return;
                }
                if((password.text).toString().trim()!=(cfpassword.text).toString().trim()){
                  Fluttertoast.showToast(msg:"New Password And confirm Password Not Matching",backgroundColor: AppColors.fntClr );
                  return;
                }
                requestBankDetails();

              },
            ),
          ],
        ),
      ),
    );
  }
}
