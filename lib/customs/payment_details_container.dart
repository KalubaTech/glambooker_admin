import 'package:flutter/material.dart';


class PaymentDetailsContainer extends StatelessWidget {

  String provider;
  String phoneNumber;
  String names;

  PaymentDetailsContainer({required this.names, required this.phoneNumber, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('$provider'.toUpperCase()),
          Text('$phoneNumber', style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('$names'),
        ],
      ),
    );
  }
}
