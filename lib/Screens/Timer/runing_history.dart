

import 'dart:async';
import 'dart:convert';

import 'package:booknplay/Screens/Timer/timer_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../../Local_Storage/shared_pre.dart';
import '../../Models/cancel_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Utils/Colors.dart';

class RuningHistory extends StatefulWidget {
  const RuningHistory({super.key});

  @override
  State<RuningHistory> createState() => _RuningHistoryState();
}

class _RuningHistoryState extends State<RuningHistory> {
  void startTimer1(int index) {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime1(index));
  }
  void addTime1(int index) {
    final addSeconds = 1;
    print('_________this${listtime.length}_______');

      final seconds = listtime[index].inSeconds + addSeconds;
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = twoDigits(listtime[index].inHours);
      final minutes = twoDigits(listtime[index].inMinutes.remainder(60));
      final seconds1 = twoDigits(listtime[index].inSeconds.remainder(60));
      print(minutes);
      // double secondprice=double.parse(seconds1)*double.parse(
      //     //"${planStartModel.data?.second}"
      //   "0.5"
      // );

      double minutesprice=double.parse(minutes)*double.parse(
          "${planStartModel.data?.minute}"
        // "1.0"
      );

      double hourprice=double.parse(hours)*double.parse(
          "${planStartModel.data?.houre}"
        //"10"
      );

      // int gameLength = planStartModel.data!.game!.length;
      //  activeplane=gameLength;
      //   glohourprice=double.parse("${planStartModel.data?.houre}");
      //   glominuteprice=double.parse("${planStartModel.data?.minute}");
      //   glosecondprice=double.parse("${planStartModel.data?.second}");
      double price=0.0;
      if(hours!="00"){
        price=hourprice;
      }
      else if(minutes!="00"){
        price=minutesprice+hourprice;
      }

      //   print(price);
      //cashcalculate=price*gameLength;
      cashwallet[index]=price;
      if(minutes=="59"){
        cashcalculate=hourprice;
      }

      if (seconds >= 3600*int.parse("${gameListModel.data?.golTimeHoure}")) {
        // String twoDigits(int n) => n.toString().padLeft(2, '0');
        // final hours = twoDigits(duration.inHours);
        // final minutes = twoDigits(duration.inMinutes.remainder(60));
        // final seconds = twoDigits(duration.inSeconds.remainder(60));
        // double secondprice=double.parse(seconds)*double.parse("${planStartModel.data?.second}");
        // double minutesprice=double.parse(minutes)*double.parse("${planStartModel.data?.minute}");
        // double hourprice=double.parse(hours)*double.parse("${planStartModel.data?.houre}");
        // int gameLength = planStartModel.data!.game!.length;
        // double price=secondprice+minutesprice+hourprice;
        // cashcalculate=price*gameLength;
        //
        // print("${cashcalculate}"+"_________________");
        // print("${gameLength}"+"_________________");
        // print("${secondprice+minutesprice+hourprice}"+"_________________");
        String twoDigits(int n) => n.toString().padLeft(2, '0');
        final hours = twoDigits(listtime[index].inHours);
        final minutes = twoDigits(listtime[index].inMinutes.remainder(60));
        final seconds1 = twoDigits(listtime[index].inSeconds.remainder(60));
        print(minutes);
        // double secondprice=double.parse(seconds1)*double.parse(
        //   "${planStartModel.data?.second}"
        //   "0.5"
        // );
        double minutesprice=double.parse(minutes)*double.parse(
            "${planStartModel.data?.minute}"
          // "1.0"
        );
        double hourprice=double.parse(hours)*double.parse(
            "${planStartModel.data?.houre}"
          //  "10"
        );
        // int gameLength = planStartModel.data!.game!.length;
        //  activeplane=gameLength;
        //   glohourprice=double.parse("${planStartModel.data?.houre}");
        //   glominuteprice=double.parse("${planStartModel.data?.minute}");
        //   glosecondprice=double.parse("${planStartModel.data?.second}");
        double price=0.0;
        if(hours!="00"){
          price=hourprice;
        }
        // else if(minutes!="00"){
        //   price=minutesprice+hourprice;
        // }

        //   print(price);
        //cashcalculate=price*gameLength;

        cashwallet[index]=price;
        cashcalculate=price;

        if(currentindex!=null) {
          if (planStartModel.data!.game!.length > 0 &&
              currentindex! < planStartModel.data!.game!.length) {
            currentindex = currentindex! + 1;
          } else {
            currentindex = null;
          }
        }
        oldgameadddata(index);
        timer?.cancel();

     //   winingaler();
      } else {
        listtime[index] = Duration(seconds: seconds);
      }

      if(mounted) {
      setState(() {});
    }
  }
  cancegame(String id,int index) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}apicancelGameCount'));
    request.body = json.encode({
      "user_id": "${await SharedPre.getStringValue('userId')}",

      "play_id":"${id}",
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      print(result);
      var finalResult = CancelModel.fromJson(json.decode(result));
      setState(() {
        cancelModel= finalResult;
        planStartModel.data?.game?.removeAt(index);
        listtime.removeAt(index);
        cashwallet.removeAt(index);
        if(listtime.length==0){
          timer?.cancel();

          activeandprogress="failed";

          currentindex=null;
        }
        // if(currentindex!=null) {
        //   if (planStartModel.data!.game!.length > 0 &&
        //       currentindex! < planStartModel.data!.game!.length) {
        //     currentindex = currentindex! +1;
        //   }
        //
        //   else {
        //     currentindex = null;
        //   }
        // }

      });
      Fluttertoast.showToast(msg: "${finalResult.message}");
    }
    else {
      print(response.reasonPhrase);
    }

  }
  Widget buildTime(String id,int index) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(listtime[index].inHours);
    final minutes = twoDigits(listtime[index].inMinutes.remainder(60));
    final seconds = twoDigits(listtime[index].inSeconds.remainder(60));
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [

      SizedBox(height: 10,),

      buildTimeCard(time: seconds, header: 'SECONDS',price: "${double.parse(planStartModel.data?.game?[index].tMinutePrice??"0.0")}"
        //"${planStartModel.data?.second??"0"}"
      ),

      SizedBox(
        height: 8,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES',price: "${int.parse(minutes)*double.parse(planStartModel.data?.game?[index].tMinutePrice??"0.0")}"),
      SizedBox(
        height: 8,
      ),

      buildTimeCard(time: hours, header: 'HOURS',price: "${int.parse(hours)*int.parse(planStartModel.data?.game?[index].tHourePrice??"0.0")}"),
      SizedBox(
        height: 8,
      ),

      buildTimeCard(time: 'Hour Use', header: 'Availabale Hours',price: "${int.parse("${planStartModel.data?.golTimeHoure??"0"}")-int.parse("${hours??"0"}")}"),
      SizedBox(
        height: 8,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title:Center(child: Text("Are You Sure",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),

                  // content:  Container(
                  //   height: 100,
                  //   child: Column(
                  //     children: [
                  //     ],
                  //   ),
                  // ),
                  actions: <Widget>[
                    InkWell(
                      onTap:(){
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)
                        ),

                        child: const Text("Cancel",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                      ),
                    ),

                    InkWell(
                      onTap:() async {
                        // buynowgame();
                        // if (enternoCon
                        //     .text != "") {
                        //   await playStartgame();
                        //   if (planStartModel
                        //       .status ==
                        //       true) {
                        //     Future.delayed(
                        //         const Duration(
                        //             seconds: 5), () {
                        //       activeandprogress =
                        //       "Progress";
                        //       // Here you can write your code
                        //
                        //       setState(() {
                        //         // Here you can write your code for open new view
                        //       });
                        //     });
                        //     // listtime.clear();
                        //     for (int i = 0; i <
                        //         planStartModel
                        //             .data!
                        //             .game!
                        //             .length; i++) {
                        //       if (!listmodel
                        //           .contains(
                        //           planStartModel
                        //               .data!
                        //               .game?[i]
                        //               .id)) {
                        //         duration =
                        //             Duration();
                        //         listmodel
                        //             .add(
                        //             planStartModel
                        //                 .data!
                        //                 .game?[i]
                        //                 .id);
                        //         listtime.add(
                        //             duration);
                        //         cashwallet
                        //             .add(
                        //             0.0);
                        //         int a = listtime
                        //             .length;
                        //         startTimer1(
                        //             a - 1);
                        //       }
                        //     }
                        //
                        //
                        //     if (currentindex ==
                        //         null) {
                        //       // startTimer1(currentindex??0);
                        //     }
                        //     currentindex = 0;
                        //     activeandprogress =
                        //     "Progress";
                        //     setState(() {
                        //
                        //     });
                        //     //  startTimer();
                        //     isplay = true;
                        //   } else {
                        //     isplay = false;
                        //   }
                        // }
                        // else {
                        //   Fluttertoast
                        //       .showToast(
                        //       msg: "Enter No. Required");
                        // }
                        // Navigator.pop(context);
                        cancegame(id,index);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)
                        ),

                        child: const Text("Ok",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              );
            //  cancegame(id,index);
            },
            child: Container(

                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.fntClr),
                    color: AppColors.whit, borderRadius: BorderRadius.circular(50)),
                child: Center(child: Text("Reset-My Table-Round",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),))),
          ),
        ],
      ),
    ]);
  }



  Widget buildTimeCard({required String time, required String header,required String price}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(

            child: Container(

                decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.secondary),
                    color: AppColors.primary, borderRadius: BorderRadius.circular(2)),
                child: Center(child: Text(header, style: TextStyle(color: AppColors.whit,fontSize: 13.5),textAlign:TextAlign.center ,))),
          ),
          SizedBox(width: 5,),
          Expanded(

            child: Container
              (

              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondary),
                  color: AppColors.whit, borderRadius: BorderRadius.circular(2)),
              child: Center(
                child: Text(
                  time,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.fntClr,
                      fontSize: 14),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(

            child: Container
              (

              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondary),
                  color: AppColors.whit, borderRadius: BorderRadius.circular(2)),
              child: Center(
                child: Text(
                  price,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.fntClr,
                      fontSize: 14),
                ),
              ),
            ),
          ),


        ],
      );
   @override
  void initState() {
    // TODO: implement initState
     var timer1=timer;
     timer?.cancel();
     timer=timer1;
     setState(() {

     });

     for(int i=1;i<planStartModel.data!.game!.length;i++){
       isplay?startTimer1(i):null;

     }
    // isplay?startTimer1(currentindex??0):null;
   //  isplay?startTimer1(0):null;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //isplay? oldgameadddata():null;
   //isplay?startTimer(currentindex??0):null;
   // isplay?startTimer(0):null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        // automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.only(
            bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
          ),),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text("Running",style: TextStyle(fontSize: 17),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius:   BorderRadius.only(
              bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
               // physics: NeverScrollableScrollPhysics(),
                itemCount:planStartModel.data?.game?.length??0 ,
                //   itemCount:listtime.length??0 ,
                itemBuilder: (context,index){

                  return
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:
                      buildTime("${planStartModel.data?.game?[index].id}",index),
                      //buildTime("",index),
                    );
                }),
          ),
        ],
      ),
    );
  }
}
