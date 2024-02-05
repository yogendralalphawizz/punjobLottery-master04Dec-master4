import 'dart:convert';

import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/my_lottery_model.dart';
import '../../Models/task_board_model.dart';
import '../../Services/api_services/apiConstants.dart';
import 'package:http/http.dart'as http;

import '../Management/chart_list.dart';
import '../Management/history_list.dart';

class TaskBoardListScreen extends StatefulWidget {
  const TaskBoardListScreen({Key? key, this.isFrom}) : super(key: key);
final bool? isFrom ;

  @override
  State<TaskBoardListScreen> createState() => _TaskBoardListScreenState();
}

class _TaskBoardListScreenState extends State<TaskBoardListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskboardlist();

  }
  String? userId;
  getUser() async {
    userId = await SharedPre.getStringValue('userId');
    get();
  }
  TaskboardListModel taskboardListModel=TaskboardListModel();
  taskboardlist() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}api_task_board_list'));
    request.body = json.encode({
      "user_id": "${await SharedPre.getStringValue('userId')}"
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      print(result);
      var finalResult = TaskboardListModel.fromJson(json.decode(result));
      setState(() {
        taskboardListModel= finalResult;
      });
      Fluttertoast.showToast(msg: "${finalResult.msg}");
    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.whit,
    //       appBar:   AppBar(
    //           backgroundColor: AppColors.primary,
    //           automaticallyImplyLeading: false,
    //         shape: const RoundedRectangleBorder(
    //           borderRadius:  BorderRadius.only(
    //             bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
    //           ),),
    //         toolbarHeight: 60,
    //         centerTitle: true,
    //         flexibleSpace: Container(
    //           decoration: const BoxDecoration(
    //             borderRadius:   BorderRadius.only(
    //               bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),
    //
    //           ),
    //         ),
    //       title: Text('Flutter Tabs Demo'),
    //   bottom: TabBar(
    //     tabs: [
    //       Tab(icon: Icon(Icons.contacts), text: "Tab 1"),
    //       Tab(icon: Icon(Icons.camera_alt), text: "Tab 2")
    //     ],
    //   ),
    // ),
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
              borderRadius:  BorderRadius.only(
                bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
              ),),
            toolbarHeight: 60,
            centerTitle: true,
            title: Text("Task Board List",style: TextStyle(fontSize: 17),),
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(color: Colors.white),
              tabs: [
                Tab(icon: Icon(Icons.insert_chart,color: Colors.white,), text: "Chart List"),
                Tab(icon: Icon(Icons.history,color: Colors.white,), text: "History")
              ],
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                borderRadius:   BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

              ),
            ),
          ),
        body:
        TabBarView(
          children: [
            Container(
              height: 400,
              child: ChartList(),
            ),
            Container(
              height: 400,
              child: HistorylistScreen(),
            ),
          ],
        ),
        // Padding(
        //   padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        //   child:Column(
        //     children: [
        //       Row(
        //         children: [
        //           Expanded(child: Text("Pakage Price",style: TextStyle(color: AppColors.fntClr,fontSize: 15,fontWeight: FontWeight.bold))),
        //           Expanded(child: Text("Minute",style: TextStyle(color: AppColors.fntClr,fontSize: 15,fontWeight: FontWeight.bold))),
        //           Expanded(child: Text("Houre",style: TextStyle(color: AppColors.fntClr,fontSize: 15,fontWeight: FontWeight.bold))),
        //           Expanded(child: Text("Minute Price",style: TextStyle(color: AppColors.fntClr,fontSize: 15,fontWeight: FontWeight.bold))),
        //           Expanded(child: Text("Houre Price",style: TextStyle(color: AppColors.fntClr,fontSize: 15,fontWeight: FontWeight.bold))),
        //
        //         ],
        //       ),
        //      Row(
        //        children: [
        //          Expanded(child: Divider(indent: 0,endIndent: 0,thickness: 2,color: AppColors.fntClr,)),
        //        ],
        //      ),
        //      SizedBox(height: 10,),
        //      Expanded(
        //        child: ListView.builder(
        //            shrinkWrap: true,
        //            itemCount:taskboardListModel.data?.length??0 ,
        //            itemBuilder: (context,index){
        //              return     Column(
        //                children: [
        //                  Row(
        //                    children: [
        //                      Expanded(child: Text("${taskboardListModel.data?[index].packagePrice??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),)),
        //                      Expanded(child: Text("${taskboardListModel.data?[index].minutes??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold))),
        //                      Expanded(child: Text("${taskboardListModel.data?[index].houre??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold))),
        //                      Expanded(child: Text("${taskboardListModel.data?[index].minutePrice??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold))),
        //                      Expanded(child: Text("${taskboardListModel.data?[index].hourePrice??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold))),
        //
        //                    ],
        //                  ),
        //                  Row(
        //                    children: [
        //                      Expanded(child: Divider(indent: 0,endIndent: 0,thickness: 2,color: AppColors.fntClr,)),
        //                    ],
        //                  ),
        //                ],
        //              );
        //        }),
        //      )
        //     ],
        //   )
        // )
      ),
    ) ;
  }

  MyLotteryModel? myLotteryModel;
  // Future<void> getLottery() async {
  //   // isLoading.value = true;
  //   var param = {
  //     'user_id':userId
  //   };
  //   apiBaseHelper.postAPICall(getLotteryAPI, param).then((getData) {
  //     String msg = getData['msg'];
  //     myLotteryModel = MyLotteryModel.fromJson(getData);
  //     setState(() {
  //
  //     });
  //     Fluttertoast.showToast(msg: msg);
  //
  //     //isLoading.value = false;
  //   });
  // }



  getLottery() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=cefaa9477065503c4ca2ed67af58f3c87c6bfab4'
    };
    var request = http.Request('POST', Uri.parse('$baseUrl1/Apicontroller/getLotteries'));
    request.body = json.encode({
      // "referred_by":userReferCode
      'user_id':userId
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = MyLotteryModel.fromJson(json.decode(result));
      setState(() {
        myLotteryModel = finalResult;
      });
      Fluttertoast.showToast(msg: "${finalResult.msg}");

    }
    else {
      print(response.reasonPhrase);
    }

  }


  get() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=4b8b6274f26a280877c08cfedab1d6e9b46e4d2d'
    };
    var request = http.Request('POST', Uri.parse('https://developmentalphawizz.com/cleverpager/Apicontroller/getLotteries'));
    request.body = json.encode({
      "user_id":userId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
     var finalResult = MyLotteryModel.fromJson(jsonDecode(result));
     setState(() {
       myLotteryModel = finalResult;
     });
     Fluttertoast.showToast(msg: "${finalResult.msg}");
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
