
import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/get_all_transaction_model.dart';

class AllTransactionHistoryScreen extends StatefulWidget {
  GetAllTransactionHistoryModel getAllTransactionHistoryModel;
  AllTransactionHistoryScreen({required this.getAllTransactionHistoryModel});

  @override
  State<AllTransactionHistoryScreen> createState() => _AllTransactionHistoryScreenState();
}

class _AllTransactionHistoryScreenState extends State<AllTransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,

        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.only(
            bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20),
          ),),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text("All Transcation History",style: TextStyle(fontSize: 17),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius:   BorderRadius.only(
              bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

          ),
        ),
      ),
      body:Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount:widget.getAllTransactionHistoryModel.data?.allTransactionHistory?.length??0 ,
                itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      title: Text("Amount: ${widget.getAllTransactionHistoryModel.data?.allTransactionHistory?[index].amount}"),
                      subtitle: Text("Date: ${widget.getAllTransactionHistoryModel.data?.allTransactionHistory?[index].insertDate}"),

                       trailing: "${widget.getAllTransactionHistoryModel.data?.allTransactionHistory?[index].transactionType}"=="1"?
                        Text("UPI"):Text("Bank")
                    ),
                  );

                }),
          )
        ],
      ) ,
    );
  }
}
