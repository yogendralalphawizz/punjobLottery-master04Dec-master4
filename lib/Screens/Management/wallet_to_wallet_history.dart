
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/wallet_to_wallet_history.dart';
import '../../Utils/Colors.dart';

class WalletToWalletHistory extends StatefulWidget {
  WalletToWalletHistoryModel walletToWalletHistoryModel;
   WalletToWalletHistory({required this.walletToWalletHistoryModel});

  @override
  State<WalletToWalletHistory> createState() => _WalletToWalletHistoryState();
}

class _WalletToWalletHistoryState extends State<WalletToWalletHistory> {
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
        title: Text("P2P History",style: TextStyle(fontSize: 17),),
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
                  itemCount:widget.walletToWalletHistoryModel.data?.length??0 ,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                          title: Text("Name: ${widget.walletToWalletHistoryModel.data?[index].userName}"),
                          subtitle: Text("Amount: ${widget.walletToWalletHistoryModel.data?[index].amount}"),
                          // trailing: "${widget.walletToWalletHistoryModel.data?.depositHistory?[index].transactionType}"=="1"?
                          // Text("UPI"):Text("Bank")

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
