import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_cradit.dart';
class WalletCreditScreen extends StatefulWidget {
  const WalletCreditScreen({super.key});

  @override
  State<WalletCreditScreen> createState() => _WalletCreditScreenState();
}

class _WalletCreditScreenState extends State<WalletCreditScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child: Text("Available Credit : 100",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
        ),
        SizedBox(height: 20,),
        Container(
          height: 40,
          width: 400,
          decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(10)
          ),
          child: InkWell(
              onTap: (){
                Get.to(AddCredit());
              },
              child: Center(child: Text("ADD CREDIT",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),))),
        )
      ],
    );
  }
}
