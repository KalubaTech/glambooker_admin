import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glambooker/controllers/bookings_controller.dart';
import 'package:glambooker/controllers/salon_controller.dart';
import 'package:glambooker/controllers/services_controller.dart';
import 'package:glambooker/customs/kalubtn.dart';
import 'package:glambooker/utils/colors.dart';
import 'package:glambooker/views/payment/checkout.dart';

import '../../models/service_model.dart';

class ViewService extends StatelessWidget {
  ServiceModel serviceModel;
  ViewService({required this.serviceModel});

  var _isFavorite = false.obs;

  DateTime dateTime = DateTime.now().add(Duration(days: 1));

  SalonController _salonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: double.infinity,
        child: GetBuilder<BookingsController>(
          builder: (bookingsController) {
            return bookingsController.bookings.value.where((b)=>b.service==serviceModel).isNotEmpty?
            Container():
            Kalubtn(
                height: 50,
                borderRadius: 40,
                label: '+ BOOK NOW',
                labelStyle: TextStyle(fontSize: 12, color: Colors.white),
                onclick: (){
                  Get.bottomSheet(
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 8,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Karas.background,
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Karas.background,
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                      child: Text('Choose appointment date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Karas.primary),),
                                    ),
                                    Expanded(
                                        child: Container(
                                          child: CalendarDatePicker(
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(Duration(days: 365*10)),
                                              onDateChanged: (data){
                                                dateTime = data;
                                              }
                                          ),
                                        )
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Kalubtn(
                                              width: 60,
                                              height: 40,
                                              borderRadius: 40,
                                              label: 'OK',
                                              onclick: (){
                                                Get.to(()=>Checkout(service: serviceModel, dateTime: dateTime), transition: Transition.fadeIn);
                                              }
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          }
        ),
      ),
        title: Container(),
        leading: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Karas.background)
          ),
          icon:Icon(Icons.arrow_back_sharp, color: Karas.primary,),
          onPressed: (){
            Get.back();
          },
        ),
        actions: [
          Obx(
            ()=>IconButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Karas.background)
              ),
              icon:Icon(!_isFavorite.value?Icons.favorite_border:Icons.favorite, color: Colors.red,),
              onPressed: (){
                _isFavorite.value=!_isFavorite.value;
              },
            ),
          ),
          SizedBox(width: 4,)
        ],
        alwaysShowLeadingAndAction: true,
        headerWidget: Stack(
          children: [
            Container(
              child: CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                  imageUrl: '${serviceModel.imageUrl}',
                  errorWidget: (c,e,i)=>Image.asset('${serviceModel.imageUrl}', width: double.infinity, height: double.infinity,fit: BoxFit.cover,),
              ),
            ),
            Positioned(
                bottom: 40,
                right: 10,
                child: Column(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.comment, color: Karas.action2,),
                          onPressed: (){},
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Karas.background.withOpacity(0.4))
                          ),
                        ),
                        Text('14.3K', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up_alt_sharp, color: Karas.action,),
                          onPressed: (){},
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Karas.background.withOpacity(0.5))
                          ),
                        ),
                        Text('20K', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ],
                )
            )
          ],
        ),
        headerExpandedHeight: 0.70,
        body: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(serviceModel.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Karas.primary),),
                Row(
                  children: [
                    Icon(Icons.star, size: 14,color: Colors.orange,),
                    SizedBox(width: 4,),
                    Text('4.4 (45%)', style: TextStyle(fontSize: 12),)
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_salonController.salon.first.salonName}', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 16, color: Karas.primary,),
                    SizedBox(width: 3,),
                    Text("${_salonController.salon.first.address}", style: TextStyle(color: Colors.grey))
                  ],
                ),
                SizedBox(height: 10,),
                Text(serviceModel.description)
              ],
            ),
          ),
        ]
    );
  }
}
