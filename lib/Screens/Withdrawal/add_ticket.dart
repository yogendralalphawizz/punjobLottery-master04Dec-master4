
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
import '../../Models/HomeModel/get_ticket_model.dart';
import '../../Models/bankdetails_model.dart';
import '../../Utils/Colors.dart';
import '../../Widgets/app_button.dart';

class AddticketScreen extends StatefulWidget {

  @override
  State<AddticketScreen> createState() => _AddticketScreenScreenState();
}

class _AddticketScreenScreenState extends State<AddticketScreen> {
  BankDetailsModel bankDetailsModel=BankDetailsModel();

  @override
  void initState() {
    // TODO: implement initState



    super.initState();

    referCode();
    getRols();
  }
  String? userId;
  referCode() async {
    userId = await SharedPre.getStringValue('userId');


  }


  bool isEditProfile = false ;

  TextEditingController subjController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
 // TextEditingController ifsccodeController = TextEditingController();

dynamic selectoption;


  GetTicketsModel getTicketsModel=GetTicketsModel();
  getRols() async {
    // Map<String,String> body={
    //   'user_id':await SharedPre.getStringValue('userId'),
    //
    // };
    //  print(body);
    final response = await http.post(Uri.parse('${baseUrl}ticket_types_get'));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      getTicketsModel=GetTicketsModel.fromJson(data);
      setState(() {});
    } else {
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
        title: Text("Add Tickets",style: TextStyle(fontSize: 17),),
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
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets
                    .symmetric(
                    horizontal: 10),
                decoration: BoxDecoration(
                    color: AppColors
                        .whit,
                    border: Border
                        .all(
                        color: AppColors
                            .fntClr),
                    borderRadius: BorderRadius
                        .circular(
                        3)),
                child: DropdownButton<
                    dynamic>(
                  hint: Text(
                    "Select By Sucess",
                    style: TextStyle(
                        color: Colors
                            .black87),
                  ),
                  value: selectoption,
                  icon: Icon(
                    Icons
                        .keyboard_arrow_down_outlined,
                    color: AppColors
                        .fntClr,
                  ),
                  items: getTicketsModel?.data
                    ?.map((
                      value) {
                    return DropdownMenuItem<
                        dynamic>(
                      value: value
                          ,
                      child: Text(
                          value.title
                              .toString()),
                    );
                  })
                      .toList(),
                  isExpanded: true,
                  underline: SizedBox(),
                  onChanged: (
                      value) async {
                    setState(() {
                      selectoption =
                          value;

                    });
                    // localmodel =
                    //     sucessModel
                    //         .data
                    //         ?.firstWhere((
                    //         element) =>
                    //     element
                    //         .sno ==
                    //         selectoption);

                  },
                ),
              ),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: emailController,
                    // readOnly: true,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                        hintText: 'Email'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    // readOnly: true,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Phone"),
                        hintText: 'Phone'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // readOnly: true,
                    // readOnly: true,
                    keyboardType: TextInputType.text,
                    controller: subjController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Subject"),
                        hintText: 'Branch Address'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // readOnly: true,
                    keyboardType: TextInputType.text,
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        label: Text("Description"),
                        hintText: 'Description'),

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
              // Container(
              //   height: 60,
              //   child: Padding(
              //
              //     padding: const EdgeInsets.all(8.0),
              //     child: TextFormField(
              //       // readOnly: true,
              //       keyboardType: TextInputType.number,
              //       controller: acnumberController,
              //       decoration: const InputDecoration(
              //           contentPadding: EdgeInsets.only(top: 5,left: 10),
              //           border: OutlineInputBorder(),
              //           label: Text("Ac Number"),
              //           hintText: 'Ac Number'),
              //
              //     ),
              //   ),
              // ),
              // Container(
              //   height: 60,
              //   child: Padding(
              //
              //     padding: const EdgeInsets.all(8.0),
              //     child: TextFormField(
              //       // readOnly: true,
              //       keyboardType: TextInputType.number,
              //       controller: ifsccodeController,
              //       decoration: const InputDecoration(
              //           contentPadding: EdgeInsets.only(top: 5,left: 10),
              //           border: OutlineInputBorder(),
              //           label: Text("Ifs code"),
              //           hintText: 'Ifs code'),
              //
              //     ),
              //   ),
              // ),

              SizedBox(height: 20,),
              AppButton(
                title: "Add",
                onTap: () async {
                  if(emailController.text==""){
                    Fluttertoast.showToast(msg:"Email Feild Required",backgroundColor: AppColors.fntClr );
                    return ;
                  }
                  if(subjController.text==""){
                    Fluttertoast.showToast(msg:" Subjetc Feild Required",backgroundColor: AppColors.fntClr );
                    return ;
                  }
                  if(descriptionController.text==""){
                    Fluttertoast.showToast(msg:"Description Feild Required",backgroundColor: AppColors.fntClr );
                    return ;
                  }
                  // if(acnumberController.text==""){
                  //   Fluttertoast.showToast(msg:"Account Number Feild Required",backgroundColor: AppColors.fntClr );
                  //   return ;
                  // }
                  // if(ifsccodeController.text==""){
                  //   Fluttertoast.showToast(msg:"Ifsc Feild Required",backgroundColor: AppColors.fntClr );
                  //   return ;
                  // }
                 updateProfile();
                  // await Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen(getProfileModel: widget.getProfileModel,)));

                },
              )

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
      "ticket_type_id":selectoption.id,
      'user_id':await SharedPre.getStringValue('userId'),
      "subject":"${subjController.text}",
      "email":"${emailController.text}",
      "description":"${descriptionController.text}",
      "phone":"${phoneController.text}"
    };
    final response = await
    http.post(Uri.parse('${baseUrl}add_ticket_post'), body:body );


    print('____request.fields______${body}_________');


    var data=  jsonDecode(response.body);
    print(data.toString()+"+++++++++++");
    if (response.statusCode == 200) {


      Fluttertoast.showToast(msg:"${data['msg']}" );
      setState(() {
        isEditProfile =  false;
      });
      Navigator.pop(context);
     // Navigator.pop(context);
    }
    else {
      setState(() {
        isEditProfile =  false;
      });
      print(response.reasonPhrase);
    }


  }
}
