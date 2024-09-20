import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:glambooker_admin/controllers/services_controller.dart';
import 'package:glambooker_admin/customs/payment_details_container.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/helpers/data_prefetch.dart';

class Methods{

  DataPrefetch _dataPrefetch = DataPrefetch();

  ServicesController _servicesController = Get.find();

  Future<String> uploadImage(_image) async {
    if (_image == null) return '';

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');

      final uploadTask = storageRef.putFile(_image!);

      final snapshot = await uploadTask.whenComplete(() {});

      final downloadUrl = await snapshot.ref.getDownloadURL();

      print('Uploaded image URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  FirebaseFirestore _fs = FirebaseFirestore.instance;

  //CHECK IF EMAIL IS ALREDY TAKEN ON SIGN UP
  Future<bool> isEmailTaken(email)async{
      var data = await _fs.collection('client').where('email', isEqualTo: email).get();

      if(data.size>0){
        return true;
      }else{
        return false;
      }
  }

  Widget paymentOptionDisplay(details){
        return PaymentDetailsContainer(names: details['names'], phoneNumber: details['contact'], provider: details['provider']);
  }


  String generateOtp() {
    // Create a Random object
    final random = Random();

    // Generate a 4-digit OTP
    int otp = 1000 + random.nextInt(9000); // Generates a number from 1000 to 9999

    // Return OTP as a string
    return otp.toString();
  }

  sendOtp(phone){
    var otp = generateOtp();
    var data = {
      "clientkey":"kalutech",
      "to":phone,
      "message":otp,
      "status":"pending"
    };

    _fs.collection('sms_pusher').add(data);
  }

  addService(_image,title,description,price)async{
    String image = await uploadImage(_image);

    var data = {
      "image":image,
      "title":title,
      "description":description,
      "price":price,
      "datetime":"${DateTime.now()}"
    };

    await _fs.collection('services').add(data);

    _dataPrefetch.fetchAllServices();
  }

}