import 'dart:convert';

import 'package:booknplay/Constants.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Auth_Views/Login/login_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/extentions.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/auth_custom_design.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../../Local_Storage/shared_pre.dart';
import '../../../Models/setting_model.dart';
import '../../../Services/api_services/apiConstants.dart';
import '../../Dashboard/BottomBar.dart';
import '../../Home/app_close_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _citypincode = TextEditingController();
   bool isloading=false;
  SettingModel settingModel=SettingModel();
  getSetting() async {

    final response = await http.post(Uri.parse('${baseUrl}api_admin_valid_settings'));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      settingModel = SettingModel.fromJson(data);
      if(settingModel.data?.loginType!="1"){
        Get.off(()=>AppCloseScreen());
      }

    } else {
      print(response.reasonPhrase);
    }
  }
  loginapi() async {
    // setState(() {
    //   isLoading=false;
    //   visible=2;
    // });

    Map<String ,String> body={

      "mobile":"${_email.text}",
      "password":"${_password.text}",
      "city_pin":"${_citypincode.text}"
    };
    print(body.toString()+"______________________");
    final response = await
    // http.post(Uri.parse('https://developmentalphawizz.com/cleverpager/Apicontroller/apiUserLogin'), body:jsonEncode(body) );
    http.post(Uri.parse('${baseUrl}apiUserLogin'), body:jsonEncode(body) );

    var data=  jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {

      if(data["status"]==true){
        Fluttertoast.showToast(
            msg: "${data["msg"]}");

        await SharedPre.setValue('userId',"${data["user_id"]}");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomBarScreen()));
      }
      else{
        Fluttertoast.showToast(
            msg: "${data["msg"]}");
        setState(() {
          isloading=false;
        });

      }




    }
    else {

      print(response.reasonPhrase);
    }

  }
  bool isread=true;
  @override
  void initState() {
    // TODO: implement initState
    getSetting();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      builder: (controller) =>
          Scaffold(
            body: WillPopScope(
              onWillPop: () async {
                SystemNavigator.pop();
                return true; // This line is necessary to avoid a lint warning
              },
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login_image.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 100,),
                        const Text("Login", style: TextStyle(
                            color: AppColors.fntClr,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),),
                        const SizedBox(height: 30,),
                        Image.asset(
                          "assets/images/login_logo.png", height: 150, width: 200,),
                        const SizedBox(height: 30,),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: textField(
                        //       title: 'Mobile Number',
                        //       prefixIcon: Icons.phone,
                        //       inputType: TextInputType.phone,
                        //       maxLength: 10,
                        //       controller: _mobile),
                        // ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          width: double.maxFinite,
                          height: 50,
                          decoration: CustomBoxDecoration.myCustomDecoration(boxShadowBlurRadius: 2),
                          child: TextFormField(
                            maxLength: 10,
                            keyboardType: TextInputType.text,
                            controller: _email,
                            decoration: const InputDecoration(
                                counterText: "",
                                hintText: "Mobile Number & User id",
                                contentPadding: EdgeInsets.only(left: 10),
                                //  prefixIcon: Icon(Icons.call),
                                border: InputBorder.none
                            ),
                            style: const TextStyle(fontSize: 14),
                                
                            validator: (val) {

                                
                              if (val!.isEmpty) {
                                return "Mobile & User id cannot be empty";
                              }
                                
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20,),
                          width: double.maxFinite,
                          height: 50,
                          decoration: CustomBoxDecoration.myCustomDecoration(boxShadowBlurRadius: 2),
                          child: TextFormField(
                            maxLength: 10,
                            keyboardType: TextInputType.text,
                            controller: _password,
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
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          width: double.maxFinite,
                          height: 50,
                          decoration: CustomBoxDecoration.myCustomDecoration(boxShadowBlurRadius: 2),
                          child: TextFormField(
                            maxLength: 6,
                            keyboardType: TextInputType.phone,
                            controller: _citypincode,
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
                                return "Pin code cannot be empty";
                              }

                                
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AppButton(
                              title: isloading == true
                                  ? 'please wait...'
                                  : 'Login', onTap: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                isloading=true;
                              });
                              loginapi();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please enter mobile number");
                            }
                          }),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.fntClr,),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(signupScreen);
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: AppColors.fntClr,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                ))
                          ],
                        )
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
