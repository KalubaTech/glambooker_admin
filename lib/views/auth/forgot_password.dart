import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/controllers/client_controller.dart';
import 'package:glambooker_admin/customs/kalubtn.dart';
import 'package:glambooker_admin/customs/kalutext.dart';
import 'package:glambooker_admin/models/client_model.dart';
import 'package:glambooker_admin/utils/colors.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  ClientController _clientController = Get.find();
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();

  TextEditingController _emailController =  TextEditingController();


  @override
  Widget build(BuildContext context) {

    ClientModel client = _clientController.client.value;


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backg.webp'),
              fit: BoxFit.cover
          )
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/gmbooker_logo.png', width: 200,),
            SizedBox(height: 20,),
            Text('Forgot your password?', style: TextStyle(fontSize: 30),),
            Text('Enter your email below.'),
            SizedBox(height: 40,),
            Kalutext(
                controller: _emailController,
                hintText: 'Enter email',
                borderRadius: BorderRadius.circular(40),
            ),
            SizedBox(height: 20,),
            Kalubtn(
              height: 45,
                label: 'Send Reset code',
                onclick: (){

                },
              borderRadius: 30,
            ),
            false?Column(
              children: [
                Text('Enter OTP sent to ${client.phone}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Karas.primary),),
                SizedBox(height: 20,),
                OtpPinField(
                  autoFillEnable: true,
                    onSubmit: (value){

                    },
                    onChange: (value){

                    },
                  otpPinFieldInputType: OtpPinFieldInputType.none,
                  otpPinFieldDecoration: OtpPinFieldDecoration.custom,
                  highlightBorder: true,
                ),
              ],
            ):Container()
          ],
        ),
      ),
    );
  }
}
