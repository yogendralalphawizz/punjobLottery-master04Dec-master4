
import 'dart:convert';
import 'dart:io';
import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:booknplay/Widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_profile_model.dart';
import '../../Utils/Colors.dart';
import '../../Widgets/app_button.dart';

class EditProfileScreen extends StatefulWidget {
   EditProfileScreen({Key? key,this.getProfileModel}) : super(key: key);
 final GetProfileModel? getProfileModel;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    nameController.text = widget.getProfileModel?.profile?.userName ?? "";
    mobileController.text = widget.getProfileModel?.profile?.mobile ?? "";
    referralcodeController.text =
        widget.getProfileModel?.profile?.referralCode ?? "";
    securitypinController.text =
        widget.getProfileModel?.profile?.securityPin ?? "";
    addressController.text = widget.getProfileModel?.profile?.address ?? "";
    adharnoController.text =
        widget.getProfileModel?.profile?.aadhaarNumber ?? "";
    pannoController.text = widget.getProfileModel?.profile?.panCard ?? "";
    txtidController.text = widget.getProfileModel?.profile?.transactionId ?? "";
    citypinController.text = widget.getProfileModel?.profile?.cityPin ?? "";
    // image = widget.getProfileModel?.profile?.image  ?? '';
    super.initState();

    referCode();
  }

  String? userId;

  referCode() async {
    userId = await SharedPre.getStringValue('userId');
  }


  bool isEditProfile = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController referralcodeController = TextEditingController();
  TextEditingController securitypinController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController adharnoController = TextEditingController();
  TextEditingController pannoController = TextEditingController();
  TextEditingController txtidController = TextEditingController();
  TextEditingController citypinController = TextEditingController();


  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  var profileImage;


  _getFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print('${imageFile}gggggg');
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(
              'Exit App',
              style: TextStyle(fontFamily: 'Lora'),
            ),
            content: Text(
              'Do you want to exit an App?',
              style: TextStyle(fontFamily: 'Lora'),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text(
                  'No',
                  style: TextStyle(fontFamily: 'Lora'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  exit(0);
                  // Navigator.pop(context,true);
                  // Navigator.pop(context,true);
                },
                //return true when click on "Yes"
                child: Text(
                  'Yes',
                  style: TextStyle(fontFamily: 'Lora'),
                ),
              ),
            ],
          ),
    ) ??
        false; //if showDialouge had returned null, then return false
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whit,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        //automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20),
          ),),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text("Edit Profile", style: TextStyle(fontSize: 17),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10),),

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Take Image From",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              ListTile(
                                leading: Image.asset(
                                  'assets/images/cameraicon.png',
                                  scale: 1.5,
                                ),
                                title: Text('Camera',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  _getFromCamera();
                                },
                              ),
                              ListTile(
                                leading: Image.asset(
                                  'assets/images/galleryicon.png',
                                  scale: 1.5,
                                ),
                                title: const Text('Gallery',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  _getFromGallery();
                                },
                              ),
                              ListTile(
                                leading: Image.asset(
                                  'assets/images/cancelicon.png',
                                  scale: 1.5,
                                ),
                                title: const Text('Cancel',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      imageFile == null
                          ? Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whit),
                        child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(100),
                            child: Image.network(
                              "",
                              fit: BoxFit.fill,
                            )),
                      )
                          : Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whit),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(100),
                          child: Image.file(
                            imageFile ?? File(''),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle),
                            child: Icon(Icons.camera_alt)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: nameController,

                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
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
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
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
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
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
              // Container(
              //   height: 60,
              //   child: Padding(
              //
              //     padding: const EdgeInsets.all(8.0),
              //     child: TextFormField(
              //
              //
              //       controller: addressController,
              //       decoration: const InputDecoration(
              //           contentPadding: EdgeInsets.only(top: 5, left: 10),
              //           border: OutlineInputBorder(),
              //           label: Text("Address"),
              //           hintText: 'Enter Address'),
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
                    controller: adharnoController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
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
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
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
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
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
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
                        border: OutlineInputBorder(),
                        label: Text("pin code"),
                        hintText: 'Enter pin code'),

                  ),
                ),
              ),
              SizedBox(height: 20,),
              AppButton(
                title: isEditProfile == true
                    ? "please wait..."
                    : "Edit Profile",
                onTap: () {
                  updateProfile();
                },
              )

            ],
          ),
        ),
      ),
    );
  }




  updateProfile() async {
    setState(() {
      isEditProfile = true;
    });

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}apiProfileUpdate'));

    // Add text fields
    request.fields['user_name'] = nameController.text;
     request.fields['user_id'] = userId.toString();
    // request.fields['mobile'] = mobileController.text;
    // request.fields['pan_card'] = pannoController.text;
    // request.fields['address'] = addressController.text;
    // request.fields['aadhaar_number'] = adharnoController.text;
    // request.fields['city_pin'] = citypinController.text;
    print(request.fields);

    // Add image file
    if(imageFile!=null) {
      request.files.add(await MultipartFile.fromPath(
          "image", "${imageFile?.path}"));
    }
    try {
      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        // Successful update
        var responseData = await response.stream.toBytes();

        var data = jsonDecode(utf8.decode(responseData));
        print(data.toString()+"____________________");
        Fluttertoast.showToast(msg: "${data['msg']}");
        setState(() {
          isEditProfile = false;
        });
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        // Handle error
        print('Error: ${response.reasonPhrase}');
        setState(() {
          isEditProfile = false;
        });
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
      setState(() {
        isEditProfile = false;
      });
    }
  }

}
