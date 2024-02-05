

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/all_deposit_balance.dart';
import '../../Utils/Colors.dart';

class DepositHistoryScreen extends StatefulWidget {
  GetAllDepositBalanceModel getAllDepositBalanceModel;
   DepositHistoryScreen({required this.getAllDepositBalanceModel});

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {
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
        title: Text("Deposit History",style: TextStyle(fontSize: 17),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius:   BorderRadius.only(
              bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:widget.getAllDepositBalanceModel.data?.depositHistory?.length??0 ,
                  itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    title: Text("\u{20B9} ${widget.getAllDepositBalanceModel.data?.depositHistory?[index].amount}"),
                    subtitle: Text("${widget.getAllDepositBalanceModel.data?.depositHistory?[index].insertDate}"),
                    trailing: "${widget.getAllDepositBalanceModel.data?.depositHistory?[index].transactionType}"=="1"?
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text("Credit",style: TextStyle(color: Colors.white),)):Container(child: Text("Debit"))

                  ),
                );

              }),
            )
          ],
        ),
      ),
    );
  }
}
