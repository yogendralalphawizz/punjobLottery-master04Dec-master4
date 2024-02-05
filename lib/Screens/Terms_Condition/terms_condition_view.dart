import 'dart:convert';

import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../../Local_Storage/shared_pre.dart';
import '../../Utils/Colors.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key, }) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getTermsApi();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          backgroundColor: AppColors.primary,

          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
            ),),
          toolbarHeight: 60,
          centerTitle: true,
          title: Text("Terms Condition",style: TextStyle(fontSize: 17),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius:   BorderRadius.only(
                bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

            ),
          ),
        ),
        body:SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  termsAndCondition == null ? Center(child: CircularProgressIndicator()) :Html(
                      data:"${termsAndCondition}"
                  )
                ],
              )
          ),
        ),
      ),
    );
  }

  String? termsAndCondition;
  // Future<void> getPrivacy() async {
  //   // isLoading.value = true;
  //   var param = {
  //     'content':'privacy_policy'
  //   };
  //   apiBaseHelper.postAPICall(getPrivacyAPI, param).then((getData) {
  //     bool status = getData['status'];
  //     String msg = getData['msg'];
  //
  //     if (status == true) {
  //       privacyPolicy = getData['content']['name'];
  //       print('privacyPolicy${privacyPolicy}_________');
  //       // getSliderModel = GetSliderModel.fromJson(getData);
  //     } else {
  //       Fluttertoast.showToast(msg: msg);
  //     }
  //     //isLoading.value = false;
  //   });
  // }

  // getTermsApi() async {
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Cookie': 'ci_session=8144c3169cc147b811c9d62284d8e56afb722df6'
  //   };
  //   var request =  http.Request('POST', Uri.parse('$baseUrl1/Apicontroller/apiGetContent'));
  //   request.body = json.encode({
  //     "content": "terms_condition"
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     final result =  await response.stream.bytesToString();
  //     final jsonResponse = json.decode(result);
  //     setState(() {
  //       termsAndCondition = jsonResponse['content'][0]['name'];
  //     });
  //
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }

  getTermsApi() async {
    Map<String,String> body={
      "content": "terms_condition"

    };
    final response = await
    http.post(Uri.parse('${baseUrl}apiGetContent'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      termsAndCondition = data['content'][0]['terms_condition'];
      Fluttertoast.showToast(msg:"${data["msg"]}",backgroundColor: AppColors.primary );

      setState(() {

      });



    }
    else {

      print(response.reasonPhrase);
    }


  }

}