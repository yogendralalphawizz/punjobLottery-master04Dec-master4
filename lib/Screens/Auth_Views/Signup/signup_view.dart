import 'dart:convert';
import 'dart:developer';

import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Auth_Views/Login/login_view.dart';
import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/extentions.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/auth_custom_design.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart'as http;
import '../../../Local_Storage/shared_pre.dart';
import '../../../Models/HomeModel/Sign_up_model.dart';
import '../../../Models/HomeModel/get_admin_code_model.dart';
import '../../../Models/HomeModel/get_profile_model.dart';
import '../../../Models/HomeModel/third_party_userdetails_model.dart';
import '../../Dashboard/Dashboard.dart';
import '../../Dashboard/BottomBar.dart';

class SignupScreen extends StatefulWidget {
  String ?referalcode;
   SignupScreen({ this.referalcode});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final referralController = TextEditingController();
  final useridController = TextEditingController();
  final txtidController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final adharController = TextEditingController();
  final pannoController = TextEditingController();
  final fulladdressController = TextEditingController();
  final citypincodeController = TextEditingController();

bool isLoading=false;

  final _formKey = GlobalKey<FormState>();
  int visible=1;
  SignUpModel signUpModel=SignUpModel();

  GetmasterAdmincodeModel getmasterAdmincodeModel=GetmasterAdmincodeModel();
  getadmincode() async {


    final response = await
    http.get(Uri.parse('${baseUrl}referred_by_admin'),  );


    print(response.statusCode);
    print(response.body);
    var data=  jsonDecode(response.body);
    if (response.statusCode == 200) {

      getmasterAdmincodeModel = GetmasterAdmincodeModel.fromJson(jsonDecode(response.body));
     // referralController.text="${getmasterAdmincodeModel.data?.referredBy}";
      setState(() {

      });


    }

  }

  signup() async {
    // setState(() {
    //   isLoading=false;
    //   visible=2;
    // });
  print(referralController.text);

  //   Map<String ,String> body={
  //   "userName":"${nameController.text}",
  //   "mobile":"${mobileController.text}",
  //   "referred_by":"${referralController.text}"
  // };
  //  print(body.toString()+"______________________");
  //   final response = await
  //   http.post(Uri.parse('${baseUrl}signUp'), body:body );
  //
  //
  //   print(response.statusCode);
  //   print(response.body);
  // var data=  jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //
  //     signUpModel = SignUpModel.fromJson(jsonDecode(response.body));
  //     print(signUpModel.data?.userId);
  //     setState(() {
  //       isLoading=false;
  //
  //     });
  //      if(signUpModel.status==true){
  //        Fluttertoast.showToast(
  //            msg: "${data["msg"]}");
  //
  //      }
  //      else{
  //        Fluttertoast.showToast(
  //            msg: "${data["msg"]}");
  //      }
  //
  //
  //
  //
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
 await getDetails();
  setState(() {

    visible=2;
  });
  }
  ThirdpartyModel thirdpartyModel=ThirdpartyModel();
  getDetails() async {
    print("jsdjsdjdjdkdkd");
    Map<String,String> body={
      'referral_code':"${referralController.text}",

    };
    print(body.toString()+"_______________--");
    final response = await
    http.post(Uri.parse('${baseUrl}users_data'), body:body );

    var data=  jsonDecode(response.body);
    log(data.toString()+"________________");
    print("jsdjsdjdjdkdkd");
    print(body);
    print("________${signUpModel.data?.userId.toString()}_________");
    if (response.statusCode == 200) {

      thirdpartyModel=ThirdpartyModel.fromJson(data);
      setState(() {

      });



    }
    else {

      print(response.reasonPhrase);
    }

  }
  GetProfileModel? getProfileModel;

  getProfile() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}apiGetProfile'));
    request.body = json.encode({
      "user_id": "${await SharedPre.getStringValue('userId')}"
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      print(result);
      var finalResult = GetProfileModel.fromJson(json.decode(result));
      setState(() {
        getProfileModel= finalResult;
      });
      Fluttertoast.showToast(msg: "${finalResult.msg}");
    }
    else {
      print(response.reasonPhrase);
    }

  }
  signupvarify() async {


    // Map<String ,String> body={
    // "aadhaar_Id":adharController.text,
    //   "user_id":"${signUpModel.data?.userId}",
    // "refferal_id": referralController.text,
    // "pan_card":pannoController.text,
    // "email_id":emailController.text,
    // "city_pin":citypincodeController.text,
    // "password":passwordController.text
    // };
    Map<String ,String> body={
    "userName":"${nameController.text}",
    "mobile":"${mobileController.text}",
    "referred_by":"${referralController.text}",
    "password":"${passwordController.text}",
    "aadhaar_Id":"${adharController.text}",

    "pan_card":"${pannoController.text}",
    "email_id":"${emailController.text}",
    "city_pin":"${citypincodeController.text}"
    };

    print(body);

    final response = await
    http.post(Uri.parse('${baseUrl}signUp'), body:body );

  var data=  jsonDecode(response.body);
     print(data);
    if (response.statusCode == 200) {
      if(data["status"]==true){

        Fluttertoast.showToast(
            msg: "${data["msg"]}");
        await SharedPre.setValue('userId',"${data["data"]["user_id"].toString()}");
       await getProfile();

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title:  Center(child: Text("Registerd Sucessfuly!",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),

            content:  Container(
              height: 150,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Name : ",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold)),
                      Text("${getProfileModel?.profile?.userName??""}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Mobile : ",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold)),
                      Text("${getProfileModel?.profile?.mobile??""}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("ReferralCode : ",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold)),
                      Text("${getProfileModel?.profile?.referralCode??""}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Transaction Id : ",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold)),
                      Text("${getProfileModel?.profile?.transactionId??""}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("User Id : ",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold)),
                      Text("${getProfileModel?.profile?.userId??""}"),
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomBarScreen()));
                //  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5)
                  ),

                  child: const Text("Close",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                ),
              ),

              // InkWell(
              //   onTap:(){
              //     // buynowgame();
              //     Navigator.pop(context);
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              //     decoration: BoxDecoration(
              //         border: Border.all(color: Colors.black),
              //         borderRadius: BorderRadius.circular(5)
              //     ),
              //
              //     child: const Text("Go to Result",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              //   ),
              // ),
            ],
          ),
        );

      }
      Fluttertoast.showToast(
          msg: "${data["msg"]}");
      setState(() {

      });



    }
    else {
      Fluttertoast.showToast(
          msg: "${data["msg"]}");
      print(response.reasonPhrase);
    }

  }
  bool isread=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getadmincode();
    getDetails();
    referralController.text=widget.referalcode??"";

  }
  String convertDate(String datetime) {
    String dateTimeString = "${datetime}";
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Remove the time portion
    DateTime dateWithoutTime = DateTime(dateTime.year, dateTime.month, dateTime.day);

    print("Original DateTime: $dateTime");
    print("DateTime without time: $dateWithoutTime");

    return dateWithoutTime.toString().split("00:00:00.000").toString().replaceAll("[", "").replaceAll("]", "").replaceAll(",", "");
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SingleChildScrollView(
       // physics: const NeverScrollableScrollPhysics(),
        child:  Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_image.png"),
              fit: BoxFit.cover,
            ),
          ),
          child:  Padding(
            padding: const EdgeInsets.only(
                right: 0, left: 0, top: 30),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    const Text("Sign Up",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold,fontSize: 25),),
                    const SizedBox(height: 20,),
                    Image.asset("assets/images/SIGN UP.png",height: 150,width: 200,),
                    const SizedBox(height: 20,),
                    visible==1?
                    Column(
                      children: [
              
                        textField(
                            title: 'User Name',
                            prefixIcon: Icons.person,
                            controller: nameController),
                        const SizedBox(
                          height: 10,
                        ),
                        textField(
                            title: 'Mobile Number',
              
                            inputType: TextInputType.phone,
                            maxLength: 10,
                            controller: mobileController),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10,),
                          width: double.maxFinite,
                          height: 50,
                          decoration: CustomBoxDecoration.myCustomDecoration(boxShadowBlurRadius: 2),
                          child: TextFormField(
                            maxLength: 10,
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            obscureText: isread,
              
                            decoration:  InputDecoration(
                                counterText: "",
                                hintText: "Password",
                                contentPadding: EdgeInsets.only(left: 10,top: 12,bottom: 10),
                                //  prefixIcon: Icon(Icons.call),
                                border: InputBorder.none,
                                suffixIcon: InkWell(
                                    onTap: (){
                                      isread=!isread;
                                      setState(() {
              
                                      });
                                    },
                                    child:isread? Icon(Icons.visibility_off):Icon(Icons.visibility))
                            ),
                            style: const TextStyle(fontSize: 14),
              
                            validator: (val) {
              
                              if (val!.isEmpty) {
                                return "Password cannot be empty";
                              }
              
                            },
                          ),
                        ),
              
                        const SizedBox(
                          height: 10,
                        ),
                        textField(
                            title: 'Referral Code(Required)',
                           // isread: true,
                            prefixIcon: Icons.person,
                            inputType: TextInputType.number,
                            controller: referralController),
                        const SizedBox(
                          height: 10,
                        ),
                        // textField(
                        //     title: 'User Id',
                        //
                        //     isread: true,
                        //     controller: useridController),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // textField1(
                        //     title: 'Txt Id',
                        //
                        //     controller: txtidController),
              
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25),
                            child: isLoading
                                ? const Center(
                              child:
                              CircularProgressIndicator(),
                            ): AppButton(
                                title: 'Next',
                                onTap: () async {
                                  // setState(() {
                                  //   visible=2;
                                  // });
              
                                  if (
                                  nameController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Name Fields Required");
                                    return;
                                  }
                                  if (mobileController.text.isEmpty ||
                                      mobileController.text.length < 10) {
                                    Fluttertoast.showToast(
                                        msg: "Please Enter 10 digit number ");
                                    return ;
                                  }
                                  if (
                                  passwordController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Password Fields Required");
                                    return;
                                  }
                                  if (
                                  referralController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Referral Code Fields Required");
                                    return;
                                  }
              
              
              
                                  else {
                                    setState(() {
                                      isLoading=true;
                                    });
                                    await  signup();
                                  };
              
                                }
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.fntClr),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(loginScreen);
                              },
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                    color: AppColors.fntClr,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ):
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                          child: Card(
                            color: AppColors.whit,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),


                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Name : ",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold)),
                                              Text("${thirdpartyModel?.data?[0]?.userName??""}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Mobile : ",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold)),
                                              Text("${thirdpartyModel?.data?[0].mobile??""}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("ReferralCode : ",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold)),
                                              Text("${thirdpartyModel?.data?[0].referralCode??""}"),
                                            ],
                                          ),
                                          (thirdpartyModel?.data?[0].referedbyamount).toString()!="0" ?
                                          Row(
                                            children: [
                                              Text("Referral Wallet: ",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold)),
                                              Text("${thirdpartyModel?.data?[0].referedbyamount??"0"}"),
                                            ],
                                          ):SizedBox.shrink(),
                                          Row(
                                            children: [
                                              Text("Joining Date: ",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold)),
                                              Text(

                                                  convertDate("${thirdpartyModel?.data?[0].insertDate??""}")

                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: double.maxFinite,
                          height: 50,
                          decoration: CustomBoxDecoration.myCustomDecoration(boxShadowBlurRadius: 2),
                          child: TextFormField(
                            maxLength: 12,
                            keyboardType: TextInputType.phone,
                            controller: adharController,
                            decoration: const InputDecoration(
                                counterText: "",
                                hintText: "Adhar Number",
                                contentPadding: EdgeInsets.only(left: 10),
                                //  prefixIcon: Icon(Icons.call),
                                border: InputBorder.none
                            ),
                            style: const TextStyle(fontSize: 14),
              
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please Enter Adhar No';
                              } else if (val.length < 12) {
                                return 'Please Enter Valid Adhar No';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        textField(
                            title: 'Enter email',
              
              
                            controller: emailController),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          width: double.maxFinite,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: CustomBoxDecoration.myCustomDecoration(boxShadowBlurRadius: 2),
                          child: TextFormField(
                            maxLength: 10,
                            keyboardType: TextInputType.text,
                            controller: pannoController,
                            decoration: const InputDecoration(
                                counterText: "",
                                hintText: "Pan Number",
                                contentPadding: EdgeInsets.only(left: 10),
                                //  prefixIcon: Icon(Icons.call),
                                border: InputBorder.none
                            ),
                            style: const TextStyle(fontSize: 14),
              
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please Enter Pan Number';
                              } else if (val.length < 10) {
                                return 'Please Enter Valid Pan Number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        textField(
                            title: 'Full Address',
              
                            inputType: TextInputType.text,
              
                            controller: fulladdressController),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          width: double.maxFinite,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: CustomBoxDecoration.myCustomDecoration(boxShadowBlurRadius: 2),
                          child: TextFormField(
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            controller: citypincodeController,

                            decoration: const InputDecoration(
                                counterText: "",

                                hintText: "Pin Code",
                                contentPadding: EdgeInsets.only(left: 10),
                                //  prefixIcon: Icon(Icons.call),
                                border: InputBorder.none
                            ),
                            style: const TextStyle(fontSize: 14),

                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please Enter Pan Number';
                              } else if (val.length < 6) {
                                return 'Please Enter Pin code';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
              
              
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  title: 'Previ',
                                  onTap: () {
                                      setState(() {
                                      visible=1;
                                    });
              
              
              
                                  },
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: AppButton(
                                  title: 'Next',
                                  onTap: () async {
              
                                    if(_formKey.currentState!.validate()!) {
                                       signupvarify();
                                      print("hello");
              
                                    }
                                    else{
              
                                    }
              
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
              
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),


      ),
    );
  }
}
