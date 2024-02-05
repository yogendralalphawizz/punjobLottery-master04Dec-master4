

import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
   AppButton({Key? key,this.onTap, this.title ,this.isloading }) : super(key: key);

 final String? title ;
  final VoidCallback? onTap ;
  bool ?isloading=false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(30),
            )),
        child:isloading??false?Center(child: CircularProgressIndicator(),):  Text(
          title ?? '',
          style: const TextStyle(
            //decoration: TextDecoration.underline,
            color: AppColors.whit,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
