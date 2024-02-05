import 'dart:async';
import 'dart:convert';

import 'package:booknplay/Screens/Timer/runing_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_profile_model.dart';
import '../../Models/HomeModel/sucess_model.dart';
import '../../Models/cancel_model.dart';
import '../../Models/gameplaylist_model.dart';
import '../../Models/list_rols.dart';
import '../../Models/plan_start_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Utils/Colors.dart';
import '../../Utils/extentions.dart';

class TimerScreen extends StatefulWidget {
  TimerScreen();

  @override
  _TimerScreenState createState() => _TimerScreenState();
}
Duration duration = Duration();
Timer? timer;
int activeplane=0;
double ?glominuteprice;
double ?glosecondprice;
double ?glohourprice;
bool isplay=false;
int ?currentindex;
List listtime=[];
List cashwallet=[];
GameListModel gameListModel=GameListModel();
PlanStartModel planStartModel=PlanStartModel();
String ?activeandprogress;
double cashcalculate=0.0;
var listmodel=[];
String? selectoption;
var listsucess=[];
int sucess=0;
CancelModel cancelModel=CancelModel();
oldgameadddata(int i) async {
  print("++++++++++++++++++++++");
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  // final hours = twoDigits(duration.inHours);
  // final minutes = twoDigits(duration.inMinutes.remainder(60));
  // final seconds = twoDigits(duration.inSeconds.remainder(60));
  var headers = {
    'Content-Type': 'application/json',
    'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
  };

  var request = http.Request('POST', Uri.parse('${baseUrl}api_transfor_Data'));
  request.body = json.encode({
    "user_id": "${await SharedPre.getStringValue('userId')}",
    "amount":"${cashcalculate}",
    //"${calculateTotal(cashwallet)}",

    "array": [
      for (int i = 0; i < planStartModel.data!.game!.length; i++)
      {
        "play_id": "${planStartModel.data!.game?[i].id}",
        "user_id": "${await SharedPre.getStringValue('userId')}",
        "second": "${twoDigits(listtime[i].inSeconds.remainder(60))}",
        "secode_price": "${planStartModel.data!.second}",
        "houre_price": "${planStartModel.data!.houre}",
        "houre": "${twoDigits(listtime[i].inHours)}",
        "minute_price": "${planStartModel.data!.minute}",
        "minute": "${twoDigits(listtime[i].inMinutes.remainder(60))}",
        "amount": "${cashwallet[i]}",
      }
    ].toList(),

  });
  print(request.body);
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var result =  await response.stream.bytesToString();
  print(result);
  if (response.statusCode == 200) {





  }
  else {
    print(response.reasonPhrase);
  }

}
void startTimer(int index) {
  timer = Timer.periodic(Duration(seconds: 1), (_) {
    addTime(index);
    print("+++++++++++++++++++");
  }
  );
}
void addTime(int index) {
  final addSeconds = 1;
  print('_________this${listtime.length}_______');
  //setState(() {
    final seconds = listtime[index].inSeconds + addSeconds;
       String twoDigits(int n) => n.toString().padLeft(2, '0');
       final hours = twoDigits(listtime[index].inHours);
       final minutes = twoDigits(listtime[index].inMinutes.remainder(60));
       final seconds1 = twoDigits(listtime[index].inSeconds.remainder(60));
      // print(minutes);
       // double secondprice=double.parse(seconds1)*double.parse(
       //     //"${planStartModel.data?.second}"
       //   "0.5"
       // );
       double minutesprice=double.parse(minutes)*double.parse(
           "${planStartModel.data?.game?[index].tMinutePrice}"
        // "1.0"
       );
      // print(  "${planStartModel.data?.game?[index].tMinutePrice}");
       double hourprice=double.parse(hours)*double.parse(
           "${planStartModel.data?.game?[index].tHourePrice}"
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
  if(minutes=="59"){
    cashcalculate=hourprice;
  }
    //   print(price);
       //cashcalculate=price*gameLength;
  print(price);
       cashwallet[index]=price;

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
          "${planStartModel.data?.game?[index].tMinutePrice}"
        // "1.0"
      );
      double hourprice=double.parse(hours)*double.parse(
          "${planStartModel.data?.game?[index].tHourePrice}"
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

     // winingaler();
    } else {
      listtime[index] = Duration(seconds: seconds);
    }
  //});
}
double calculateTotal(List<dynamic> amounts) {
  double total = 0.0;
  for (double amount in amounts) {
    total += amount;
  }
  return total;
}
class _TimerScreenState extends State<TimerScreen> {
  static var countdownDuration = Duration(minutes: 10);
  static var countdownDuration1 = Duration(minutes: 10);
  // Duration duration = Duration();
  Duration duration1 = Duration();
  // Timer? timer;
  Timer? timer1;
  bool countDown = true;
  bool countDown1 = true;
 // GameListModel gameListModel=GameListModel();
  BuyNowModel buyNowModel=BuyNowModel();

  String ?playerId;
  // List listtime=[];
  // List cashwallet=[];
  getgamelist() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}api_game_Package_list'));
    request.body = json.encode({
      "user_id": "${await SharedPre.getStringValue('userId')}"
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      print(result);
      var finalResult = GameListModel.fromJson(json.decode(result));
      setState(() {
        gameListModel= finalResult;
      });
      Fluttertoast.showToast(msg: "${finalResult.msg}");
    }
    else {
      print(response.reasonPhrase);
    }

  }
  SucessModel sucessModel=SucessModel();
  getSucesslist() async {
    Map<String,String> body={
      'user_id':await SharedPre.getStringValue('userId'),

    };
    //  print(body);
    final response = await http.post(Uri.parse('${baseUrl}list_of_activegame'),body: body);

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      sucessModel = SucessModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }
  winingaler(){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:  Center(child: Text("Plan Price Rs. ${gameListModel.data?.packagePrice??"0"}/-",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),

        content:  Container(
          height: 150,
          child: Column(
            children: [
              Image.asset("assets/images/thumb.png",width: 100,height: 100,fit: BoxFit.contain,),
              SizedBox(height: 10,),

              Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 4),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text("You Buy In Single Conform",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap:(){
              Navigator.pop(context);
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

          InkWell(
            onTap:(){
             // buynowgame();
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)
              ),

              child: const Text("Go to Result",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }
  CheckPlanModel checkPlanModel=CheckPlanModel();

  TextEditingController enternoCon=TextEditingController();
  // checkPlan() async {
  //   print('___________________________');
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
  //   };
  //
  //   var request = http.Request('POST', Uri.parse('${baseUrl}apiCheckGamePlanBuy'));
  //   request.body = json.encode({
  //     "user_id": "${await SharedPre.getStringValue('userId')}"
  //   });
  //   print(request.body);
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //
  //     var result =  await response.stream.bytesToString();
  //     print(result);
  //     var finalResult = CheckPlanModel.fromJson(json.decode(result));
  //     setState(() {
  //       checkPlanModel= finalResult;
  //       print("${checkPlanModel.data?.playerId}"+"_______________");
  //       playerId="${checkPlanModel.data?.playerId}";
  //     });
  //     Fluttertoast.showToast(msg: "${finalResult.msg}");
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }
int count=0;

  var minutes;
  var hourly;
  buynowgame() async {

    setState(() {

    });
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}api_game_buy_now'));
    request.body = json.encode({
      "user_id": "${await SharedPre.getStringValue('userId')}",
      "packeage_id":"${gameListModel.data?.packageId}",
      "count":"${count}",
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      var data=json.decode(result);
      print(result);
      Fluttertoast.showToast(msg: "${data["msg"]}");
      // var finalResult = BuyNowModel.fromJson(json.decode(result));

      if(data["status"]==true){
        var finalResult = BuyNowModel.fromJson(json.decode(result));
        setState(() {
          buyNowModel= finalResult;
          playerId="${buyNowModel.data?.playerId}";

        });
        count++;
       // activeandprogress=null;
        setState(() {
          activeandprogress=int.parse("${buyNowModel.data?.currentStatus}")==0?"Failed":"Sucess";
          minutes="${buyNowModel.data?.minute}";
          hourly="${buyNowModel.data?.houre}";
          // Here you can write your code for open new view
        });
        if(activeandprogress=="Failed"){
          Future.delayed(const Duration(seconds: 1), () {
           // activeandprogress = "Active";
//
              minutes="0";
             hourly="0";
            setState(() {
              // Here you can write your code for open new view
            });
          });
        }
        else {
          sucess++;
          listsucess.add(sucess.toString());
          Future.delayed(const Duration(seconds: 25), () {
            minutes="0";
            hourly="0";
            activeandprogress = "Active";
//

            setState(() {

              // Here you can write your code for open new view
            });
          });
        }
        getSucesslist();
      }
      else{

        Fluttertoast.showToast(msg: "${data["msg"]}");
      }

    }
    else {
      print(response.reasonPhrase);
    }

  }

  transfermoney() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}api_transfor_Data'));
    request.body = json.encode({
      "user_id": "${await SharedPre.getStringValue('userId')}",

      "amount":"${cashcalculate}",
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      print(result);

      var data=jsonDecode(result);
     Fluttertoast.showToast(msg: "${data["msg"]}");
    }
    else {
      print(response.reasonPhrase);
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
        if(listtime.length==0||listtime.isEmpty){
          timer?.cancel();
          timer1?.cancel();
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


  playStartgame() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };

    var request = http.Request('POST', Uri.parse('${baseUrl}api_game_plays'));
    request.body = json.encode({
      "user_id": "${await SharedPre.getStringValue('userId')}",

      "player_id":"${playerId}",
      "success_count":"${enternoCon.text}"
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var result =  await response.stream.bytesToString();
      print('______result___this${result}_______');
      var data=json.decode(result);
      Fluttertoast.showToast(msg: "${data['message']}");
      var finalResult = PlanStartModel.fromJson(data);

      setState(() {
        planStartModel= finalResult;
      });
     // Fluttertoast.showToast(msg: "${finalResult.message}");
    }
    else {
      print(response.reasonPhrase);
    }

  }
  RolesListModel rolesListModel = RolesListModel();
 dynamic ?localmodel;
 bool istimestatus=false;
  getRols() async {
    // Map<String,String> body={
    //   'user_id':await SharedPre.getStringValue('userId'),
    //
    // };
    //  print(body);
    final response = await http.post(Uri.parse('${baseUrl}api_ListofRoles'));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      rolesListModel = RolesListModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }
  getimecheck() async {
    Map<String,String> body={
      'user_id':await SharedPre.getStringValue('userId'),

    };
    //  print(body);
    final response = await http.post(Uri.parse('${baseUrl}api_time_management'),body: body);

    var data = jsonDecode(response.body);
    print(data.toString() + "jksdfjkjkdsjkdfsjkdssdjk");
    if (response.statusCode == 200) {
      istimestatus=data['status'];
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }



  void startTimer1(int index) {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime1(index));
  }
  void addTime1(int index) {
    final addSeconds = 1;
   // print('_________this${listtime.length}_______');
    setState(() {
    final seconds = listtime[index].inSeconds + addSeconds;
       String twoDigits(int n) => n.toString().padLeft(2, '0');
       final hours = twoDigits(listtime[index].inHours);
       final minutes = twoDigits(listtime[index].inMinutes.remainder(60));
       final seconds1 = twoDigits(listtime[index].inSeconds.remainder(60));
       //print(minutes);
       // double secondprice=double.parse(seconds1)*double.parse(
       //     //"${planStartModel.data?.second}"
       //   "0.5"
       // );

       double minutesprice=double.parse(minutes)*double.parse(
           "${planStartModel.data?.game?[index].tMinutePrice}"
        // "1.0"
       );

       double hourprice=double.parse(hours)*double.parse(
          "${planStartModel.data?.game?[index].tHourePrice}"
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
          "${planStartModel.data?.game?[index].tMinutePrice}"
        // "1.0"
      );
      double hourprice=double.parse(hours)*double.parse(
          "${planStartModel.data?.game?[index].tHourePrice}"
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

       winingaler();
    } else {
      listtime[index] = Duration(seconds: seconds);
    }
    });
  }
  @override
  void initState() {
    var hours;
    var mints;
    var secs;
    hours = int.parse("00");
    mints = int.parse("00");
    secs = int.parse("00");

    countdownDuration = Duration(hours: hours, minutes: mints, seconds: secs);
    getRols();
    getgamelist();
    getSucesslist();
    getProfile1();
    getimecheck();
 //   checkPlan();
    var timer1=timer;
    timer?.cancel();
    timer=timer1;
    setState(() {

    });
    isplay?startTimer1(currentindex??0):null;
    reset();

    super.initState();
  }
@override
  void dispose() {
    // TODO: implement dispose
 //isplay? oldgameadddata():null;

 //isplay?startTimer(currentindex??0):null;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.greyColor,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
         // automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
            ),),
          toolbarHeight: 60,
          centerTitle: true,
          title: Text("Playner",style: TextStyle(fontSize: 17),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius:   BorderRadius.only(
                bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

            ),
          ),
        ),
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),

              decoration: BoxDecoration(
                  color: AppColors.whit,
                  border: Border.all(color: AppColors.fntClr),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                     Material(
                       borderRadius: BorderRadius.circular(10),
                       color: AppColors.whit,
                       elevation: 3,
                       child: Container(
                         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                         decoration: BoxDecoration(
                             color: AppColors.whit,
                             border: Border.all(color: AppColors.fntClr),
                             borderRadius: BorderRadius.circular(10)),
                         child: Center(
                           child: Text("Playner", style: TextStyle(
                               color: AppColors.fntClr,
                               fontSize: 16,
                               fontWeight: FontWeight.bold),),
                         ) ,
                       ),
                     ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.whit,
                          border: Border.all(color: AppColors.fntClr),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tips",style: TextStyle(
                          color: AppColors.fntClr,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: HtmlWidget(
                                '''
                         ${rolesListModel.data?.playerRole?? ""}
                                      ''',
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                       decoration: BoxDecoration(
                           color: AppColors.whit,
                           border: Border.all(color: AppColors.fntClr),
                           borderRadius: BorderRadius.circular(10)),
                       child: Center(
                         child: Column(
                           children: [
                             Row(

                                 mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 buildContainer("Plan Price","${gameListModel.data?.packagePrice??"0"}"),
                                 SizedBox(width: 5,),
                                 buildContainer("1 Minutes","${minutes??"0"}"),
                                 SizedBox(width: 5,),
                                 buildContainer("1 Hourly","${hourly??"0"}"),
                               ],
                             ),
                                               SizedBox(height: 20,),
                                               Wrap(
                              children: [

                                buildContainer1("Times","${buyNowModel.data?.failed??"0"}"),
                                SizedBox(width: 10,),
                                Text("Result-Pointer",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold,fontSize: 16),),
                                SizedBox(width: 10,),
                                buildContainer1("Sucess",
                                    listsucess.join(",")

                                    // (int.parse("${buyNowModel.data?.success??"0"}")-int.parse("${enternoCon.text==""?0:enternoCon.text}")).toString()
                                    // "${buyNowModel.data?.success??"0"}"

                                ),
                              ],
                                               ),
                             SizedBox(height: 20,),
                                               Container(
                                                 height: 120,
                                                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                                                 decoration: BoxDecoration(
                                                     color: AppColors.whit,
                                                     border: Border.all(color: AppColors.fntClr),
                                                     borderRadius: BorderRadius.circular(20)),
                                                 child: Center(child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   children: [
                                                    // Text("Result :",style: TextStyle(color: AppColors.fntClr,fontSize: 20,fontWeight: FontWeight.bold),),
                                                   activeandprogress!=null?Text("${activeandprogress}",style: TextStyle(color: AppColors.fntClr,fontSize: 20,fontWeight: FontWeight.bold)): Text("Progress",style: TextStyle(color: AppColors.fntClr,fontSize: 20,fontWeight: FontWeight.bold))
                                                   // int.parse("${ buyNowModel.data?.success??"0"}",)>0?int.parse("${ buyNowModel.data?.failed??"0"}")<=0?Text("Sucess",style: TextStyle(color: AppColors.fntClr,fontSize: 25,fontWeight: FontWeight.bold)):Text("Sucess",style: TextStyle(color: AppColors.fntClr,fontSize: 25,fontWeight: FontWeight.bold)):Text("Failed",style: TextStyle(color: AppColors.fntClr,fontSize: 25,fontWeight: FontWeight.bold))
                                                    ],
                                                 )),
                                               ),


                                               SizedBox(height: 20,),
                                               Container(
                                                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                                                   decoration: BoxDecoration(
                                                       color: AppColors.whit,
                                                       border: Border.all(color: AppColors.fntClr),
                                                       borderRadius: BorderRadius.circular(20)),
                                                   child: Center(child: Text("Times-On Money(${gameListModel.data?.golTimeHoure}) Hours",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold,fontSize: 18),))),


                             SizedBox(height: 20,),
                             Row(
                               children: [
                                 buyNowModel.data?.buyNow.toString()=="0"||istimestatus==false?SizedBox.shrink():
                                 InkWell(
                                   onTap: () async {
                                     showDialog(
                                       context: context,
                                       builder: (ctx) => AlertDialog(
                                         title:  Center(child: Text("Plan Price Rs. ${gameListModel.data?.packagePrice??"0"}/-",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),

                                         content:  Container(
                                           height: 150,
                                           child: Column(
                                             children: [
                                               Image.asset("assets/images/thumb.png",width: 100,height: 100,fit: BoxFit.contain,),
                                              SizedBox(height: 10,),

                                               Container(
                                                 padding: EdgeInsets.symmetric(vertical: 5,horizontal: 4),
                                                   decoration: BoxDecoration(
                                                     border: Border.all(color: Colors.black),
                                                     borderRadius: BorderRadius.circular(5)
                                                   ),
                                                   child: Text("You Buy In Single Conform",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
                                             ],
                                           ),
                                         ),
                                         actions: <Widget>[
                                           InkWell(
                                             onTap:(){
                                               Navigator.pop(context);
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

                                           InkWell(
                                             onTap:(){
                                               buynowgame();


                                               Navigator.pop(context);
                                             },
                                             child: Container(
                                               padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                                               decoration: BoxDecoration(
                                                   border: Border.all(color: Colors.black),
                                                   borderRadius: BorderRadius.circular(5)
                                               ),

                                               child: const Text("Go to Result",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                             ),
                                           ),
                                         ],
                                       ),
                                     );
//                                      showDialog(
//                                        context: context,
//                                        builder: (ctx) => AlertDialog(
//                                          title:  Center(child: Text("00:00:00",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
//
//                                          content:  Container(
//                                            height: 150,
//                                            child: Column(
//                                              children: [
//
//                                                Row(
//                                                  children: [
//                                                    Expanded(
//                                                      child: Column(
//                                                        children: [
//                                                          Text("Minute's",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                                          Text("1",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                                          Text("Rs.${gameListModel.data?.minutePrice}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                                        ],
//                                                      ),
//                                                    ),
//                                                    Expanded(
//                                                      child: Column(
//                                                        children: [
//                                                          Text("Hour's",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                                          Text("1",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                                          Text("Rs.${gameListModel.data?.hourePrice}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                                        ],
//                                                      ),
//                                                    ),
//                                                    Expanded(
//                                                      child: Column(
//                                                        children: [
//                                                          Text("Total",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                                          Text("Time",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                                          Text("[${gameListModel.data?.golTimeHoure}H]",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                                        ],
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                                SizedBox(height: 20,),
//
//                                                Container(
//                                                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 4),
//                                                    decoration: BoxDecoration(
//                                                        border: Border.all(color: Colors.black),
//                                                        borderRadius: BorderRadius.circular(5)
//                                                    ),
//                                                    child: Text("Select By Sucess /1/2/3/4",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
//                                              ],
//                                            ),
//                                          ),
//                                          actions: <Widget>[
//                                            InkWell(
//                                              onTap:(){
//                                                Navigator.pop(context);
//                                              },
//                                              child: Container(
//                                                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
//                                                decoration: BoxDecoration(
//                                                    border: Border.all(color: Colors.black),
//                                                    borderRadius: BorderRadius.circular(5)
//                                                ),
//
//                                                child: const Text("Close",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                                              ),
//                                            ),
//
//                                            InkWell(
//                                              onTap:() async {
//                                                // if(enternoCon.text!="") {
//                                                //   await playStartgame();
//                                                //   if (planStartModel.status == true) {
//                                                //     listtime.clear();
//                                                //     for(int i=0;i<planStartModel.data!.game!.length;i++) {
//                                                //       duration = Duration();
//                                                //       listtime.add(duration);
//                                                //       cashwallet.add(0.0);
//                                                //       int a = listtime.length;
//                                                //       startTimer(a-1);
//                                                //
//                                                //     }
//                                                //     setState(() {
//                                                //
//                                                //     });
//                                                //     //  startTimer();
//                                                //     isplay=true;
//                                                //   } else {
//                                                //     isplay=false;
//                                                //   }
//                                                // }
//                                                // else{
//                                                //   Fluttertoast.showToast(
//                                                //       msg: "Enter No. Required");
//                                                // }
//                                                // Navigator.pop(context);
//                                                buynowgame();
//
//                                                Navigator.pop(context);
//                                                Future.delayed(const Duration(seconds: 5), () {
//                                                    activeandprogress="active";
// // Here you can write your code
//
//                                                  setState(() {
//                                                    // Here you can write your code for open new view
//                                                  });
//
//                                                });
//                                              },
//                                              child: Container(
//                                                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
//                                                decoration: BoxDecoration(
//                                                    border: Border.all(color: Colors.black),
//                                                    borderRadius: BorderRadius.circular(5)
//                                                ),
//
//                                                child: const Text("Start Now",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      );

                                   //  buynowgame();
                                   },
                                   child: Container(
                                       height: 35,
                                       padding: EdgeInsets.symmetric(horizontal: 20),
                                       decoration: BoxDecoration(
                                         // border: Border.all(color: AppColors.secondary),

                                           borderRadius: BorderRadius.circular(20),
                                           color: AppColors.primary
                                       ),
                                       child: Center(child: Text("Buy Now",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.normal,fontSize: 14)))),
                                 ),
                                 Expanded(
                                   child: Container(
                                     height: 35,
                                     margin: EdgeInsets.symmetric(horizontal: 10,),
                                     padding: EdgeInsets.symmetric(horizontal: 10,),
                                     width: double.maxFinite,

                                     decoration: CustomBoxDecoration.myCustomDecoration(boxShadowBlurRadius: 2,color: AppColors.whit,borderRadius: 20,),
                                     child: Center(
                                       child: TextFormField(

                                         keyboardType: TextInputType.phone,
                                         controller: enternoCon,
                                         //obscureText: isread,
                                          textAlign: TextAlign.center,
                                         decoration:  InputDecoration(
                                           counterText: "",

                                           hintText: "Enter No",

                                           hintStyle: TextStyle(color: AppColors.fntClr),

                                           //  prefixIcon: Icon(Icons.call),
                                           border: InputBorder.none,

                                         ),
                                         style: const TextStyle(fontSize: 14),

                                         validator: (val) {


                                         },
                                       ),
                                     ),
                                   ),
                                 ),

                                 InkWell(
                                   onTap: () async {
                                     if(listsucess.isEmpty){
                                       Fluttertoast.showToast(
                                           msg: "You have not any sucess plan");
                                     }
                                     else {
                                       print(sucessModel.data?[0].tMinutePrice);
                                       localmodel =
                                           sucessModel.data?.firstWhere((
                                               element) =>
                                           element.sno.toString() ==
                                               listsucess[0].toString());
                                       print(localmodel.tHourePrice);
                                       selectoption = localmodel.sno.toString();
                                       setState(() {

                                       });
                                       print(localmodel.sno);
                                       showDialog(
                                         context: context,
                                         builder: (ctx) =>
                                             StatefulBuilder(
                                                 builder: (context, setState) {
                                                   return AlertDialog(
                                                     title: Center(child: Text(
                                                         "00:00:00",
                                                         style: TextStyle(
                                                             color: Colors
                                                                 .black,
                                                             fontWeight: FontWeight
                                                                 .bold))),

                                                     content: Container(
                                                       height: 150,
                                                       child: Column(
                                                         children: [

                                                           Row(
                                                             children: [
                                                               Expanded(
                                                                 child: Column(
                                                                   children: [
                                                                     Text(
                                                                       "Minute's",
                                                                       style: TextStyle(
                                                                           color: Colors
                                                                               .black,
                                                                           fontWeight: FontWeight
                                                                               .bold),),
                                                                     Text(
                                                                       "${localmodel
                                                                           .tMinute ??
                                                                           ""}",
                                                                       style: TextStyle(
                                                                           color: Colors
                                                                               .black,
                                                                           fontWeight: FontWeight
                                                                               .bold),),
                                                                     Text(
                                                                       "Rs.${localmodel
                                                                           .tMinutePrice ??
                                                                           ""}",
                                                                       style: TextStyle(
                                                                           color: Colors
                                                                               .black,
                                                                           fontWeight: FontWeight
                                                                               .bold),
                                                                       //
                                                                     ),
                                                                   ],
                                                                 ),
                                                               ),
                                                               Expanded(
                                                                 child: Column(
                                                                   children: [
                                                                     Text(
                                                                       "Hour's",
                                                                       style: TextStyle(
                                                                           color: Colors
                                                                               .black,
                                                                           fontWeight: FontWeight
                                                                               .bold),),
                                                                     Text(
                                                                       "${localmodel
                                                                           .tHoure ??
                                                                           ""}",
                                                                       style: TextStyle(
                                                                           color: Colors
                                                                               .black,
                                                                           fontWeight: FontWeight
                                                                               .bold),),
                                                                     Text(
                                                                       "Rs.${localmodel
                                                                           .tHourePrice ??
                                                                           ""}",
                                                                       style: TextStyle(
                                                                           color: Colors
                                                                               .black,
                                                                           fontWeight: FontWeight
                                                                               .bold),),
                                                                     //

                                                                   ],
                                                                 ),
                                                               ),
                                                               Expanded(
                                                                 child: Column(
                                                                   children: [
                                                                     Text(
                                                                       "Total",
                                                                       style: TextStyle(
                                                                           color: Colors
                                                                               .black,
                                                                           fontWeight: FontWeight
                                                                               .bold),),
                                                                     Text(
                                                                       "Time",
                                                                       style: TextStyle(
                                                                           color: Colors
                                                                               .black,
                                                                           fontWeight: FontWeight
                                                                               .bold),),
                                                                     Text(
                                                                       "[${gameListModel
                                                                           .data
                                                                           ?.golTimeHoure}H]",
                                                                       style: TextStyle(
                                                                           color: Colors
                                                                               .black,
                                                                           fontWeight: FontWeight
                                                                               .bold),),
                                                                   ],
                                                                 ),
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(
                                                             height: 20,),

                                                           // Container(
                                                           //     padding: EdgeInsets.symmetric(vertical: 5,horizontal: 4),
                                                           //     decoration: BoxDecoration(
                                                           //         border: Border.all(color: Colors.black),
                                                           //         borderRadius: BorderRadius.circular(5)
                                                           //     ),
                                                           //     child: Text("Select By Sucess /1/2/3/4",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),

                                                           SizedBox(
                                                             height: 10,
                                                           ),
                                                           Row(
                                                             children: [
                                                               Expanded(
                                                                 child: Container(
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
                                                                           10)),
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
                                                                     items: listsucess
                                                                         .map((
                                                                         value) {
                                                                       return DropdownMenuItem<
                                                                           dynamic>(
                                                                         value: value
                                                                             .toString(),
                                                                         child: Text(
                                                                             value
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
                                                                             value
                                                                                 .toString();
                                                                       });
                                                                       localmodel =
                                                                           sucessModel
                                                                               .data
                                                                               ?.firstWhere((
                                                                               element) =>
                                                                           element
                                                                               .sno ==
                                                                               selectoption);
                                                                       print(
                                                                           localmodel
                                                                               .tHourePrice);
                                                                     },
                                                                   ),
                                                                 ),
                                                               ),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                     actions: <Widget>[
                                                       InkWell(
                                                         onTap: () {
                                                           Navigator.pop(
                                                               context);
                                                         },
                                                         child: Container(
                                                           padding: EdgeInsets
                                                               .symmetric(
                                                               vertical: 8,
                                                               horizontal: 20),
                                                           decoration: BoxDecoration(
                                                               border: Border
                                                                   .all(
                                                                   color: Colors
                                                                       .black),
                                                               borderRadius: BorderRadius
                                                                   .circular(5)
                                                           ),

                                                           child: const Text(
                                                             "Close",
                                                             style: TextStyle(
                                                                 color: Colors
                                                                     .black,
                                                                 fontWeight: FontWeight
                                                                     .bold),),
                                                         ),
                                                       ),

                                                       InkWell(
                                                         onTap: () async {
                                                           // if(enternoCon.text!="") {
                                                           //   await playStartgame();
                                                           //   if (planStartModel.status == true) {
                                                           //     listtime.clear();
                                                           //     for(int i=0;i<planStartModel.data!.game!.length;i++) {
                                                           //       duration = Duration();
                                                           //       listtime.add(duration);
                                                           //       cashwallet.add(0.0);
                                                           //       int a = listtime.length;
                                                           //       startTimer(a-1);
                                                           //
                                                           //     }
                                                           //     setState(() {
                                                           //
                                                           //     });
                                                           //     //  startTimer();
                                                           //     isplay=true;
                                                           //   } else {
                                                           //     isplay=false;
                                                           //   }
                                                           // }
                                                           // else{
                                                           //   Fluttertoast.showToast(
                                                           //       msg: "Enter No. Required");
                                                           // }
                                                           // Navigator.pop(context);
                                                          // Navigator.pop(context);
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
                                                                     if (enternoCon
                                                                         .text != "") {
                                                                       await playStartgame();
                                                                       if (planStartModel
                                                                           .status ==
                                                                           true) {
                                                                         Future.delayed(
                                                                             const Duration(
                                                                                 seconds: 5), () {
                                                                           activeandprogress =
                                                                           "Progress";
                                                                           // Here you can write your code

                                                                           setState(() {
                                                                             // Here you can write your code for open new view
                                                                           });
                                                                         });
                                                                         // listtime.clear();
                                                                         for (int i = 0; i <
                                                                             planStartModel
                                                                                 .data!
                                                                                 .game!
                                                                                 .length; i++) {
                                                                           if (!listmodel
                                                                               .contains(
                                                                               planStartModel
                                                                                   .data!
                                                                                   .game?[i]
                                                                                   .id)) {
                                                                             duration =
                                                                                 Duration();
                                                                             listmodel
                                                                                 .add(
                                                                                 planStartModel
                                                                                     .data!
                                                                                     .game?[i]
                                                                                     .id);
                                                                             listtime.add(
                                                                                 duration);
                                                                             cashwallet
                                                                                 .add(
                                                                                 0.0);
                                                                             int a = listtime
                                                                                 .length;
                                                                             startTimer1(
                                                                                 a - 1);
                                                                           }
                                                                         }
                                                                             for(int i=0;i<listsucess.length;i++){
                                                                               if(enternoCon.text==listsucess[i]){
                                                                                 listsucess.removeAt(i);
                                                                                 setState(() {

                                                                                 });
                                                                               }
                                                                             }

                                                                         if (currentindex ==
                                                                             null) {
                                                                           // startTimer1(currentindex??0);
                                                                         }
                                                                         currentindex = 0;
                                                                         Future.delayed(
                                                                             const Duration(
                                                                                 seconds: 10), () {
                                                                           activeandprogress =
                                                                           "Progress";
                                                                           // Here you can write your code

                                                                           setState(() {
                                                                             // Here you can write your code for open new view
                                                                           });
                                                                         });
                                                                         // activeandprogress =
                                                                         // "Progress";
                                                                         // setState(() {
                                                                         //
                                                                         // });
                                                                         //  startTimer();
                                                                         isplay = true;
                                                                       } else {
                                                                         isplay = false;
                                                                       }
                                                                     }
                                                                     else {
                                                                       Fluttertoast
                                                                           .showToast(
                                                                           msg: "Enter No. Required");
                                                                     }
                                                                     Navigator.pop(context);
                                                                     Navigator.pop(context);
                                                                   },
                                                                   child: Container(
                                                                     padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                                                                     decoration: BoxDecoration(
                                                                         border: Border.all(color: Colors.black),
                                                                         borderRadius: BorderRadius.circular(5)
                                                                     ),

                                                                     child: const Text("Play Game",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                                                   ),
                                                                 ),
                                                               ],
                                                             ),
                                                           );


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
                                                           // setState(() {
                                                           //   activeandprogress=null;
                                                           // });


                                                         },
                                                         child: Container(
                                                           padding: EdgeInsets
                                                               .symmetric(
                                                               vertical: 8,
                                                               horizontal: 20),
                                                           decoration: BoxDecoration(
                                                               border: Border
                                                                   .all(
                                                                   color: Colors
                                                                       .black),
                                                               borderRadius: BorderRadius
                                                                   .circular(5)
                                                           ),

                                                           child: const Text(
                                                               "Start Now",
                                                               style: TextStyle(
                                                                   color: Colors
                                                                       .black,
                                                                   fontWeight: FontWeight
                                                                       .bold)),
                                                         ),
                                                       ),
                                                     ],
                                                   );
                                                 }
                                             ),
                                       );
                                     }
                                     // if(enternoCon.text!="") {
                                     //   await playStartgame();
                                     //   if (planStartModel.status == true) {
                                     //    // listtime.clear();
                                     //     for(int i=0;i<planStartModel.data!.game!.length;i++) {
                                     //       if(!listmodel.contains(planStartModel.data!.game?[i].id)) {
                                     //         duration = Duration();
                                     //         listmodel.add(planStartModel.data!.game?[i].id);
                                     //         listtime.add(duration);
                                     //         cashwallet.add(0.0);
                                     //         int a = listtime.length;
                                     //       }
                                     //     }
                                     //
                                     //
                                     //       if(currentindex==null){
                                     //         startTimer1(currentindex??0);
                                     //       }
                                     //     currentindex=0;
                                     //     activeandprogress="Progress";
                                     //     setState(() {
                                     //
                                     //     });
                                     //   //  startTimer();
                                     //     isplay=true;
                                     //   } else {
                                     //     isplay=false;
                                     //   }
                                     // }
                                     // else{
                                     //   Fluttertoast.showToast(
                                     //       msg: "Enter No. Required");
                                     // }
                                     // isplay=true;
                                     // duration=Duration();
                                     // listtime.add(duration);
                                     // cashwallet.add(0.0);
                                     // int a=listtime.length;
                                     // startTimer(a-1);
                                     //
                                     //     setState(() {
                                     //
                                     //     });
                                   },
                                   child: Container(
                                       height: 35,
                                       padding: EdgeInsets.symmetric(horizontal: 20),
                                       decoration: BoxDecoration(
                                         // border: Border.all(color: AppColors.secondary),

                                           borderRadius: BorderRadius.circular(20),
                                           color: AppColors.primary
                                       ),
                                       child: Center(child: Text("Play Start",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.normal,fontSize: 14)))),
                                 )
                               ],
                             ),
                           ],
                         ),
                       ),
                     ),

                    SizedBox(height: 20,),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                        decoration: BoxDecoration(
                            color: AppColors.whit,
                            border: Border.all(color: AppColors.fntClr),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(child: Text("Play Start Record-History(${planStartModel.data?.game?.length??"0"})",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold,fontSize: 18),))),

                  //  SizedBox(height: 20,),


              // ListView.builder(
              //   shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //      itemCount:planStartModel.data?.game?.length??0 ,
              //  //   itemCount:listtime.length??0 ,
              //     itemBuilder: (context,index){
              //   return
              //     Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 10),
              //     child:
              //      buildTime("${planStartModel.data?.game?[index].id}",index),
              //     //buildTime("",index),
              //   );
              // }),

              // buildTime(),
                    currentindex!=null?
                    Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child:
                buildTime("${planStartModel.data?.game?[currentindex??0].id}",currentindex??0),
                //buildTime("",index),
              ):SizedBox.shrink(),




                    // SizedBox(height: 20,),
                    // Text("Reset-My Table-Round",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold,fontSize: 15),),
                    //
              SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    child: Container(

                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whit
                      ),
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Collect-Wallet",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(height: 10,),
                Text("Rs."
                    "${
                 cashcalculate


                }/",style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold,fontSize: 15),),

              ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      children: [
              InkWell(
                onTap: (){
                  if(listtime.isEmpty){
                    Fluttertoast.showToast(msg: "Not Runing Any Game");
                  }else {
                    Get.to(() => RuningHistory())?.then((value) {
                           print("+++++++++++runing+++++++++++");
                      var timer1=timer;
                      timer?.cancel();
                      timer=timer1;
                      setState(() {

                      });

                           for(int i=1;i<planStartModel.data!.game!.length;i++){
                             isplay?startTimer1(i):null;

                           }
                    });
                  }
                },
                child: Container(

                    decoration: BoxDecoration(
                      // border: Border.all(color: AppColors.secondary),
                        color: AppColors.secondary1, borderRadius: BorderRadius.circular(2)),
                    child: Center(child: Text("Running(${planStartModel.data?.game?.length??0-int.parse("${cancelModel.data?.cancelCount??"0"}")})", style: TextStyle(color: AppColors.whit,fontSize: 18)))),
              ),
              SizedBox(height: 5,),
              Container(

                  decoration: BoxDecoration(
                    // border: Border.all(color: AppColors.secondary),
                      color: AppColors.secondary, borderRadius: BorderRadius.circular(2)),
                  child: Center(child: Text("Cancel(${cancelModel.data?.cancelCount??"0"})", style: TextStyle(color: AppColors.whit,fontSize: 18)))),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                  //if(cashcalculate>0.0){
                    _showBottomSheet();
                    //transfermoney();
                 // }
                 //  else{
                 //    Fluttertoast.showToast(msg: "Collect Wallet Is Rs.0");
                 //  }

                },
                child: Container(

                    decoration: BoxDecoration(
                      // border: Border.all(color: AppColors.secondary),

                        color: Colors.green, borderRadius: BorderRadius.circular(2)),
                    child: Center(child: Text("Transfer", style: TextStyle(color: AppColors.whit,fontSize: 18)))),
              ),
                      ],
                    ),
                  ),


                ],
              ),
                    SizedBox(height: 20,),
                    // Container(
                    //     margin: EdgeInsets.only(top: 30, bottom: 30),
                    //     child: buildTime()),


                    // Container(
                    //     margin: EdgeInsets.only(top: 30, bottom: 30),
                    //     child: buildTime1()),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Material buildContainer1(String title,String count) {
    return Material(
      borderRadius: BorderRadius.circular(3),
      color: AppColors.whit,
      elevation: 2,
      child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondary),
                      borderRadius: BorderRadius.circular(3),
                    color: AppColors.whit
                  ),
                  child: Text("${title}(${count})",style: TextStyle(color: AppColors.fntClr.withOpacity(0.5),fontWeight: FontWeight.bold,fontSize: 16)),
                ),
    );
  }

  Material buildContainer(String title,String price) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.whit,
      elevation: 2,
      child: Container(

                 padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                 decoration: BoxDecoration(
                   border: Border.all(color: AppColors.secondary),
                   borderRadius: BorderRadius.circular(10),
                     color: AppColors.whit
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("${title}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold,fontSize: 16),),
                         SizedBox(height: 10,),
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                         decoration: BoxDecoration(
                             border: Border.all(color: AppColors.secondary),
                            borderRadius: BorderRadius.circular(20),
                             //shape: BoxShape.circle,
                             color: AppColors.whit
                         ),
                         child: Center(child: Text("Rs.${price}/",style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold,fontSize: 15),))),

                   ],
                 ),
               ),
    );
  }

  Future<bool> _onWillPop() async {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      timer!.cancel();
    }
   // isplay? oldgameadddata():null;
    Navigator.of(context, rootNavigator: true).pop(context);
    return true;
  }
  TextEditingController enterpiccon=TextEditingController();
  GetProfileModel? getProfileModel1;
  getProfile1() async {
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
        getProfileModel1= finalResult;
      });
      Fluttertoast.showToast(msg: "${finalResult.msg}");
    }
    else {
      print(response.reasonPhrase);
    }

  }
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  controller: enterpiccon,
                  decoration: InputDecoration(
                    hintText: 'Enter 4-digit number',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle submit logic here
                    // print("${enterpiccon.text}"+"-----");
                    // print("${getProfileModel1?.profile?.transactionId}"+"-----");
                    //
                    // print("${getProfileModel1?.profile?.transactionId}"=="${enterpiccon.text}");

                    if(enterpiccon.text==""){
                      Fluttertoast.showToast(
                          msg: "Enter  Pin",
                          backgroundColor: AppColors.primary);
                    }else {
                      if (int.parse(
                          "${getProfileModel1?.profile?.transactionId}") ==
                          int.parse("${enterpiccon.text}")) {
                         oldgameadddata(0);
                       // transfermoney();
                        enterpiccon.clear();
                        //amtC.clear();
                        // Navigator.pop(context);
                      }
                      else {
                        Fluttertoast.showToast(
                            msg: "Enter Wrong Pin",
                            backgroundColor: AppColors.primary);
                      }
                    }
                    // Close bottom sheet
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }



  // void startTimer(int index) {
  //   timer = Timer.periodic(Duration(seconds: 1), (_) => addTime(index));
  // }



  // void addTime(int index) {
  //   final addSeconds = 1;
  //   print('_________this${listtime.length}_______');
  //   setState(() {
  //     final seconds = listtime[index].inSeconds + addSeconds;
  //  //    String twoDigits(int n) => n.toString().padLeft(2, '0');
  //  //    final hours = twoDigits(listtime[index].inHours);
  //  //    final minutes = twoDigits(listtime[index].inMinutes.remainder(60));
  //  //    final seconds1 = twoDigits(listtime[index].inSeconds.remainder(60));
  //  //    print(minutes);
  //  //    // double secondprice=double.parse(seconds1)*double.parse(
  //  //    //     //"${planStartModel.data?.second}"
  //  //    //   "0.5"
  //  //    // );
  //  //    double minutesprice=double.parse(minutes)*double.parse(
  //  //        "${planStartModel.data?.minute}"
  //  //     // "1.0"
  //  //    );
  //  //    print(  "${planStartModel.data?.minute}");
  //  //    double hourprice=double.parse(hours)*double.parse(
  //  //       "${planStartModel.data?.houre}"
  //  //      //"10"
  //  //    );
  //  //   // int gameLength = planStartModel.data!.game!.length;
  //  //  //  activeplane=gameLength;
  //  //  //   glohourprice=double.parse("${planStartModel.data?.houre}");
  //  //  //   glominuteprice=double.parse("${planStartModel.data?.minute}");
  //  //  //   glosecondprice=double.parse("${planStartModel.data?.second}");
  //  //    double price=0.0;
  //  //    if(hours!="00"){
  //  //      price=hourprice;
  //  //    }
  //  //    else if(minutes!="00"){
  //  //      price=minutesprice+hourprice;
  //  //    }
  //  //
  //  // //   print(price);
  //  //    //cashcalculate=price*gameLength;
  //  //    cashwallet[index]=price;
  //
  //     if (seconds >= 3600*int.parse("${gameListModel.data?.golTimeHoure}")) {
  //       // String twoDigits(int n) => n.toString().padLeft(2, '0');
  //       // final hours = twoDigits(duration.inHours);
  //       // final minutes = twoDigits(duration.inMinutes.remainder(60));
  //       // final seconds = twoDigits(duration.inSeconds.remainder(60));
  //       // double secondprice=double.parse(seconds)*double.parse("${planStartModel.data?.second}");
  //       // double minutesprice=double.parse(minutes)*double.parse("${planStartModel.data?.minute}");
  //       // double hourprice=double.parse(hours)*double.parse("${planStartModel.data?.houre}");
  //       // int gameLength = planStartModel.data!.game!.length;
  //       // double price=secondprice+minutesprice+hourprice;
  //       // cashcalculate=price*gameLength;
  //       //
  //       // print("${cashcalculate}"+"_________________");
  //       // print("${gameLength}"+"_________________");
  //       // print("${secondprice+minutesprice+hourprice}"+"_________________");
  //       String twoDigits(int n) => n.toString().padLeft(2, '0');
  //       final hours = twoDigits(listtime[index].inHours);
  //       final minutes = twoDigits(listtime[index].inMinutes.remainder(60));
  //       final seconds1 = twoDigits(listtime[index].inSeconds.remainder(60));
  //       print(minutes);
  //       // double secondprice=double.parse(seconds1)*double.parse(
  //         //   "${planStartModel.data?.second}"
  //       //   "0.5"
  //       // );
  //       double minutesprice=double.parse(minutes)*double.parse(
  //          "${planStartModel.data?.minute}"
  //          // "1.0"
  //       );
  //       double hourprice=double.parse(hours)*double.parse(
  //         "${planStartModel.data?.houre}"
  //         //  "10"
  //       );
  //       // int gameLength = planStartModel.data!.game!.length;
  //       //  activeplane=gameLength;
  //       //   glohourprice=double.parse("${planStartModel.data?.houre}");
  //       //   glominuteprice=double.parse("${planStartModel.data?.minute}");
  //       //   glosecondprice=double.parse("${planStartModel.data?.second}");
  //       double price=0.0;
  //       if(hours!="00"){
  //         price=hourprice;
  //       }
  //       // else if(minutes!="00"){
  //       //   price=minutesprice+hourprice;
  //       // }
  //
  //       //   print(price);
  //       //cashcalculate=price*gameLength;
  //
  //       cashwallet[index]=price;
  //       timer?.cancel();
  //       winingaler();
  //     } else {
  //       listtime[index] = Duration(seconds: seconds);
  //     }
  //   });
  // }



  Widget buildTime(String id,int index) {

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(listtime[index].inHours);
    final minutes = twoDigits(listtime[index].inMinutes.remainder(60));
    final seconds = twoDigits(listtime[index].inSeconds.remainder(60));
    print(planStartModel.data?.game?[index].tMinutePrice.toString()??""+"++++++++++++++++++=");
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

      buildTimeCard(time: hours, header: 'HOURS',price: "${int.parse(hours)*double.parse(planStartModel.data?.game?[index].tHourePrice??"0.0")}"),
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

              // cancegame(id,index);
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
}




class BuyNowModel {
  bool? status;
  String? message;
  BuyNowData? data;

  BuyNowModel({this.status, this.message, this.data});

  BuyNowModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BuyNowData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BuyNowData {
  int? buyNow;
  int? playerId;
  String? failed;
  String? success;
  int? currentStatus;
  String? minute;
  String? houre;

  BuyNowData(
      {this.buyNow,
        this.playerId,
        this.failed,
        this.success,
        this.currentStatus,
        this.minute,
        this.houre});

  BuyNowData.fromJson(Map<String, dynamic> json) {
    buyNow = json['buy_now'];
    playerId = json['player_id'];
    failed = json['failed'];
    success = json['success'];
    currentStatus = json['current_status'];
    minute = json['minute'];
    houre = json['houre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy_now'] = this.buyNow;
    data['player_id'] = this.playerId;
    data['failed'] = this.failed;
    data['success'] = this.success;
    data['current_status'] = this.currentStatus;
    data['minute'] = this.minute;
    data['houre'] = this.houre;
    return data;
  }
}






// class BuyNowModel {
//   bool? status;
//   String? message;
//   BuyNowData? data;
//
//   BuyNowModel({this.status, this.message, this.data});
//
//   BuyNowModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new BuyNowData.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class BuyNowData {
//   int? buyNow;
//   int? playerId;
//   String ?failed;
//   String ?success;
//
//
//   BuyNowData({this.buyNow, this.playerId,this.failed,this.success});
//
//   BuyNowData.fromJson(Map<String, dynamic> json) {
//     buyNow = json['buy_now'];
//     playerId = json['player_id'];
//     failed=json['failed'];
//     success=json['success'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['buy_now'] = this.buyNow;
//     data['player_id'] = this.playerId;
//     data['failed']=this.failed;
//     data['success']=this.success;
//     return data;
//   }
// }



class CheckPlanModel {
  String? msg;
  bool? status;
  CheckPlanData? data;

  CheckPlanModel({this.msg, this.status, this.data});

  CheckPlanModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
    data = json['data'] != null ? new CheckPlanData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CheckPlanData {
  String? playerId;

  CheckPlanData({this.playerId});

  CheckPlanData.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    return data;
  }
}
