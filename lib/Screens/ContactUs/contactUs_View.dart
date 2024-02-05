import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../../Models/HomeModel/contact_us_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/Colors.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key, }) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getContact();

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
        body:contactUsModel == null ? Center(child: CircularProgressIndicator(color: AppColors.primary,)): SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: double.infinity,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mobile No.: +91${contactUsModel?.mobile1}\n+91${contactUsModel?.mobile2}",textAlign: TextAlign.end,),
                        const SizedBox(height: 5,),
                        Text("WhatsApp No.: ${contactUsModel?.whatsappNo}"),
                        const SizedBox(height: 5,),
                        Text("Email Us: ${contactUsModel?.email1} OR\n${contactUsModel?.email2}",textAlign: TextAlign.end,),
                        const SizedBox(height: 5,),
                        Text("FaceBook: ${contactUsModel?.facebook}"),
                        const SizedBox(height: 5,),
                        Text("Twitter: ${contactUsModel?.twitter}"),
                        const SizedBox(height: 5,),
                        Text("${contactUsModel?.msg}"),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ContactUsModel?contactUsModel;
  // Future<void> getContact() async {
  //   apiBaseHelper.postAPICall2(getContactAPI).then((getData) {
  //     setState(() {
  //       contactUsModel = ContactUsModel.fromJson(getData);
  //     });
  //
  //     //isLoading.value = false;
  //   });
  // }
  getContact() async {

    final response = await
    http.post(Uri.parse('${baseUrl}apiGetContactDetails'));

    var data=  jsonDecode(response.body);
    print(data.toString()+"________________");
    if (response.statusCode == 200) {
      contactUsModel = ContactUsModel.fromJson(data);
      Fluttertoast.showToast(msg:"${data["msg"]}",backgroundColor: AppColors.primary );

      setState(() {

      });



    }
    else {

      print(response.reasonPhrase);
    }


  }
}