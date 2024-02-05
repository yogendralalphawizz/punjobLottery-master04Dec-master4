
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/history_model.dart';
import '../../Models/task_board_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Utils/Colors.dart';


class HistorylistScreen extends StatefulWidget {
  const HistorylistScreen({super.key});

  @override
  State<HistorylistScreen> createState() => _HistorylistScreenState();
}

class _HistorylistScreenState extends State<HistorylistScreen> {
  HistoryModel taskboardListModel=HistoryModel();
  taskboardlist() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}api_Game_History'));
    request.body = json.encode({
      "user_id": "${await SharedPre.getStringValue('userId')}"
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      print(result);
      var finalResult = HistoryModel.fromJson(json.decode(result));
      setState(() {
        taskboardListModel= finalResult;
      });
      Fluttertoast.showToast(msg: "${finalResult.message}");
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
      body:
      Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child:Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Row(
                    children: [
                      //Expanded(child: Text("Plan Price",style: TextStyle(color: AppColors.fntClr,fontSize: 16,fontWeight: FontWeight.bold))),
                      Expanded(child: Text("Minute's Price",style: TextStyle(color: AppColors.fntClr,fontSize: 16,fontWeight: FontWeight.bold))),

                      Expanded(child: Text("Second's Price",style: TextStyle(color: AppColors.fntClr,fontSize: 16,fontWeight: FontWeight.bold))),

                      Expanded(child: Text("Houre's Price",style: TextStyle(color: AppColors.fntClr,fontSize: 16,fontWeight: FontWeight.bold))),

                      Expanded(child: Text("Status",style: TextStyle(color: AppColors.fntClr,fontSize: 16,fontWeight: FontWeight.bold))),

                    ],
                  ),
                ),
              ),
            
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:taskboardListModel.data?.length??0 ,
                    itemBuilder: (context,index){
                      return     Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text("${taskboardListModel.data?[index].minutePrice??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 14,fontWeight: FontWeight.bold),)),
                              Expanded(
                                  flex: 2,
                                  child: Text("${taskboardListModel.data?[index].secondAmount??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 14,fontWeight: FontWeight.bold))),
                              Expanded(
                                  flex: 2,
                                  child: Text("${taskboardListModel.data?[index].hourePrice??"0"}",style: TextStyle(color: AppColors.fntClr,fontSize: 14,fontWeight: FontWeight.bold))),

                              "${taskboardListModel.data?[index].status??"0"}"=="2"  ?
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(child: Text("Cancel",style: TextStyle(color: AppColors.whit,fontSize: 14,fontWeight: FontWeight.bold))))): "${taskboardListModel.data?[index].status??"0"}"=="1" ||"${taskboardListModel.data?[index].markStatus??"0"}"=="2"?

                              Expanded(
                                flex: 2,
                                  child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(child: Text("completed",style: TextStyle(color: AppColors.whit,fontSize: 14,fontWeight: FontWeight.bold))))):SizedBox.shrink(),


                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          )
      ),
    );
  }
}
