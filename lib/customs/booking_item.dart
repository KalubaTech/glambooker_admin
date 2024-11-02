import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/controllers/bookings_controller.dart';
import 'package:glambooker_admin/controllers/client_controller.dart';
import 'package:glambooker_admin/customs/kalubtn.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/booking_model.dart';

class BookingItem extends StatelessWidget {
  BookingModel booking;
  BookingItem({required this.booking});

  BookingsController _bookingsController = Get.find();
  ClientController _clientController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: (){
        booking.status=='pending'?
        Get.defaultDialog(
          title: '',
          content: Container(
            child: Kalubtn(
                label: 'Delete',
                onclick: (){
                  _bookingsController.remove(booking);
                  Get.back();
                }),
          )
        ):
        null;
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: booking.status=='pending'?Colors.blue:Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Booking ID: ${booking.bookingId}', style: TextStyle(fontWeight: FontWeight.bold),),

              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: CachedNetworkImage(
                    imageUrl:booking.service.first.imageUrl,
                    width: 100,
                    height:90,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.service.first.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    Text('K${booking.service.first.price}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    Text('${booking.isPaid?'Paid':'Not paid'}', style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),),
                    Text('${booking.dateTime.toString().split(' ').first}', style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              child: Column(
                children: [
                  Text('Client'),
                  ...
                  _clientController.clients.where((e){
                    return e.uid == booking.client;
                  }).map((client)=>Text('${client.name}')).toList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
