import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;

import 'package:flutter/cupertino.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_ticket_model.dart';
import '../../Models/getticketlist_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Utils/Colors.dart';
import '../Withdrawal/add_ticket.dart';
import 'chat_page.dart';

class GetTicketList extends StatefulWidget {
  const GetTicketList({super.key});

  @override
  State<GetTicketList> createState() => _GetTicketListState();
}

class _GetTicketListState extends State<GetTicketList> {
  @override
  void initState() {
    // TODO: implement initState
    getRols();
    super.initState();
  }
  GetTicketsListModel getTicketsModel=GetTicketsListModel();
  getRols() async {
    Map<String,String> body={
      'user_id':await SharedPre.getStringValue('userId'),

    };
    //  print(body);
    final response = await http.post(Uri.parse('${baseUrl}get_tickets_post'),body: body);
    print(response.request?.url);
    var data = jsonDecode(response.body);
    print(data.toString() + "________________");
    if (response.statusCode == 200) {
      getTicketsModel=GetTicketsListModel.fromJson(data);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
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
        title: Text("Support",style: TextStyle(fontSize: 17),),
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
                itemCount:getTicketsModel.data?.length??0,
                itemBuilder: (context,index){
              return InkWell(
             onTap: (){
               Get.to(()=>Chat(id: "${getTicketsModel.data?[index].id}",));
             },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(title: Text("${getTicketsModel.data?[index].description}"),
                      subtitle:Text("${getTicketsModel.data?[index].dateCreated}") ,
                      trailing:"${getTicketsModel.data?[index].status}"=="0"?
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)
                        ),
                     child:   Text("Close",style: TextStyle(color: Colors.white,fontSize: 12),)
                      ): Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child:   Text("Open",style: TextStyle(color: Colors.white,fontSize: 12),)
                      )

                      ,),

                  ),
                ),
              );
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
       // shape: BoxShape.circle,
        backgroundColor: AppColors.primary,
        onPressed: (){
       Get.to(()=>AddticketScreen())?.then((value) => getRols());

       },
      child: Icon(Icons.add),
      ),
    );
  }
}
