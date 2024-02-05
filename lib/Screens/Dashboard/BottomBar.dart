import 'dart:convert';

import 'package:booknplay/Constants.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Dashboard/dashboard_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:booknplay/Widgets/drawer_icon_tab_widget.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../Models/setting_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../AddMoney/add_money.dart';
import '../Home/home_view.dart';
import '../Management/chart_list.dart';
import '../Management/management_screen.dart';
import '../Profile/profile_view.dart';
import '../Result/result_view.dart';
import '../TaskBoard/TaskBoardList.dart';
import '../Timer/timer_count.dart';
import 'Dashboard.dart';

class BottomBarScreen extends StatefulWidget {
  BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  //final GlobalKey<ScaffoldState> _key = GlobalKey();
  int currentIndex = 1 ;
  int bottomIndex = 0;
  SettingModel settingModel=SettingModel();
  getSetting() async {
    // Map<String,String> body={
    //   'user_id':await SharedPre.getStringValue('userId'),
    //
    // };
    //  print(body);
    final response = await http.post(Uri.parse('${baseUrl}api_admin_valid_settings'));

    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      settingModel = SettingModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }
  List <Widget> pageList  = [
    Dashboard(),
    ManagementScreen(),
  // TaskBoardListScreen(isFrom: false),
    TimerScreen(),
   // ChartList(),
    ProfileScreen()
  ];
@override
  void initState() {
    // TODO: implement initState
  getSetting();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Display a confirmation dialog when the back button is pressed.
        bool exit = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Exit App'),
              content: Text('Are you sure you want to exit the app?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Cancel exit
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Confirm exit
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );

        return exit ?? false; // Exit if the user confirmed (true) or continue if canceled (false).
      },
      child: Scaffold(

                bottomNavigationBar: CurvedNavigationBar(
                  //buttonBackgroundColor: Colors.white,
                  color: AppColors.primary,
                  backgroundColor: AppColors.whit,
                  items: const [
                    CurvedNavigationBarItem(

                        child: Icon(Icons.dashboard,color: Colors.white,),
                        label: 'Dashboard',
                        labelStyle: TextStyle(color: AppColors.whit)
                    ),
                    CurvedNavigationBarItem(
                        child: Icon(Icons.manage_accounts,color: Colors.white,),

                        label: 'Management',
                        labelStyle: TextStyle(color: AppColors.whit)
                    ),
                    // CurvedNavigationBarItem(
                    //     child: Icon(Icons.games,color: Colors.white,),
                    //
                    //
                    //     label: 'Game',
                    //     labelStyle: TextStyle(color: AppColors.whit)
                    // ),
                    CurvedNavigationBarItem(
                        child: Icon(Icons.games,color: Colors.white,),
                        label: 'Playner',
                        labelStyle: TextStyle(color: AppColors.whit)
                    ),
                    CurvedNavigationBarItem(
                        child: ImageIcon(AssetImage(AppConstants.profileIcon),
                            color: AppColors.whit),
                        label: 'Account',
                        labelStyle: TextStyle(color: AppColors.whit)
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      bottomIndex = index;
                    });

                    //Handle button tap
                  },
                ),
              key: _key,

              backgroundColor: AppColors.whit,
              body: pageList[bottomIndex]

            ),
    );
  }
}
