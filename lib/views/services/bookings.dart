import 'package:flutter/material.dart';
import 'package:glambooker/controllers/bookings_controller.dart';
import 'package:glambooker/customs/booking_item.dart';
import 'package:glambooker/models/booking_model.dart';
import 'package:glambooker/utils/colors.dart';
import 'package:get/get.dart';

class Bookings extends StatelessWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Karas.background,
      appBar: AppBar(
        backgroundColor: Karas.background,
        title: Text('My Bookings'),
      ),
      body: GetBuilder<BookingsController>(
        builder: (bookingController) {
          List<BookingModel> bookings = bookingController.bookings.value;
          return Container(
            child: bookings.isNotEmpty?ListView(
              children: [
                ... 
                    bookings.map((booking)=>BookingItem(booking: booking))
              ],
            ):Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, size: 40, color: Colors.orange,),
                  SizedBox(height: 20,),
                  Text('No bookings!')
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
