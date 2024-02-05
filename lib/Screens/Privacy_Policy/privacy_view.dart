import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/Colors.dart';
import 'package:http/http.dart'as http;

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key, }) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getPrivacy();

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
          title: Text("Privacy Policy",style: TextStyle(fontSize: 17),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius:   BorderRadius.only(
                bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                privacyPolicy == null ? Center(child: CircularProgressIndicator()) :Html(
                    data:"${privacyPolicy}"
                )
              ],
            )
          ),
        ),
      ),
    );
  }


  String? privacyPolicy;
  // getPrivacy() async {
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Cookie': 'ci_session=8144c3169cc147b811c9d62284d8e56afb722df6'
  //   };
  //   var request = http.Request('POST', Uri.parse('$baseUrl1/Apicontroller/apiGetContent'));
  //   request.body = json.encode({
  //     "content": "privacy_policy"
  //   });
  //   print('_____request.body_____${request.body}_________');
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     final result =  await response.stream.bytesToString();
  //     final jsonResponse = json.decode(result);
  //     print(jsonResponse.toString()+"_____________");
  //     setState(() {
  //       privacyPolicy = jsonResponse['content'][0]['name'];
  //     });
  //
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }

  getPrivacy() async {
    Map<String,String> body={
      "content": "privacy_policy"

    };
    final response = await
    http.post(Uri.parse('${baseUrl}apiGetContent'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {

      privacyPolicy = data['content'][0]['name'];
      Fluttertoast.showToast(msg:"${data["msg"]}",backgroundColor: AppColors.primary );

      setState(() {

      });



    }
    else {

      print(response.reasonPhrase);
    }


  }
}