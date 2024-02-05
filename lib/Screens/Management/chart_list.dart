

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/task_board_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Utils/Colors.dart';

class ChartList extends StatefulWidget {
  const ChartList({super.key});

  @override
  State<ChartList> createState() => _ChartListState();
}

class _ChartListState extends State<ChartList> {
  TaskboardListModel taskboardListModel=TaskboardListModel();
  taskboardlist() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}api_task_board_list2'));
    // request.body = json.encode({
    //   "user_id": "${await SharedPre.getStringValue('userId')}"
    // });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      print(result.toString()+"++++++++++++++++++=");
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
  void initState() {
    // TODO: implement initState
    taskboardlist();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.primary,
      //   automaticallyImplyLeading: false,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius:  BorderRadius.only(
      //       bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
      //     ),),
      //   toolbarHeight: 60,
      //   centerTitle: true,
      //   title: Text("Chart List",style: TextStyle(fontSize: 17),),
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //       borderRadius:   BorderRadius.only(
      //         bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),
      //
      //     ),
      //   ),
      // ),
      body:
      Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child:Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text("Raide Price",style: TextStyle(color: AppColors.fntClr,fontSize: 16,fontWeight: FontWeight.bold))),
                  SizedBox(width: 10,),
                  Expanded(child: Text("Per Minute's",style: TextStyle(color: AppColors.fntClr,fontSize: 16,fontWeight: FontWeight.bold))),
                  SizedBox(width: 10,),
                  Expanded(child: Text("Gol Time's",style: TextStyle(color: AppColors.fntClr,fontSize: 16,fontWeight: FontWeight.bold))),
                  SizedBox(width: 10,),
                  Expanded(child: Text("Run Pay",style: TextStyle(color: AppColors.fntClr,fontSize: 16,fontWeight: FontWeight.bold))),
                  SizedBox(width: 10,),

                ],
              ),
              Row(
                children: [
                  Expanded(child: Divider(indent: 0,endIndent: 0,thickness: 2,color: AppColors.fntClr,)),
                ],
              ),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:taskboardListModel.data?.length??0 ,
                    itemBuilder: (context,index){
                      return     Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text("${taskboardListModel.data?[index].price??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 14,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              Expanded(child: Text("${taskboardListModel.data?[index].perMinute??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 14,fontWeight: FontWeight.bold))),
                              SizedBox(width: 10,),
                              Expanded(child: Text("${taskboardListModel.data?[index].golTime??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 14,fontWeight: FontWeight.bold))),
                              SizedBox(width: 10,),
                              Expanded(child: Text("${taskboardListModel.data?[index].runPay??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 14,fontWeight: FontWeight.bold))),
                              // Expanded(child: Text("${taskboardListModel.data?[index].hourePrice??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold))),
                              SizedBox(width: 10,),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Divider(indent: 0,endIndent: 0,thickness: 2,color: AppColors.fntClr,)),
                            ],
                          ),
                        ],
                      );
                    }),
              )
            ],
          )
      ),
    );
  }
}
