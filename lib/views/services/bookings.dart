import 'package:flutter/material.dart';
import 'package:glambooker_admin/controllers/bookings_controller.dart';
import 'package:glambooker_admin/controllers/services_controller.dart';
import 'package:glambooker_admin/customs/booking_item.dart';
import 'package:glambooker_admin/models/booking_model.dart';
import 'package:glambooker_admin/utils/colors.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/service_model.dart';

class Bookings extends StatelessWidget {
  Bookings({super.key});


  ServicesController _servicesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Karas.background,
      appBar: AppBar(
        backgroundColor: Karas.background,
        title: Text('Bookings'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){

            List<BookingModel> bookings = snapshot.data!.docs.map((doc) {
              ServiceModel service = _servicesController.services.where((s)=>s.uid==doc.get('service')).first;
              return BookingModel(
                  bookingId: doc.id,
                  service: [service],
                  isPaid: doc.get('isPaid'),
                  status: doc.get('status'),
                  dateTime: doc.get('datetime').toString(),
                  dateBooked: doc.get('dateBooked').toString(),
                  client: doc.get('clientID')
              );
            }
            ).toList();
            return Container(
              child: ListView(
                children: [
                  ...
                  bookings.map((booking)=>BookingItem(booking: booking))
                ],
              )
            );
          }else{
            return Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, size: 40, color: Colors.orange,),
                  SizedBox(height: 20,),
                  Text('No bookings found!')
                ],
              ),
            );
          }

        }
      ),
    );
  }
}
