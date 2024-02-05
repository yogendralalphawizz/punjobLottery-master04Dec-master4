

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/Colors.dart';

class AppCloseScreen extends StatefulWidget {
  const AppCloseScreen({super.key});

  @override
  State<AppCloseScreen> createState() => _AppCloseScreenState();
}

class _AppCloseScreenState extends State<AppCloseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: AppColors.primary,
        //
        //   shape: const RoundedRectangleBorder(
        //     borderRadius:  BorderRadius.only(
        //       bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
        //     ),),
        //   toolbarHeight: 60,
        //   centerTitle: true,
        //   title: Text("App Is Close",style: TextStyle(fontSize: 17),),
        //   flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //       borderRadius:   BorderRadius.only(
        //         bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),
        //
        //     ),
        //   ),
        // ),
      
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text("Under Process!"))
          ],
        ),
      ),
    );
  }
}
