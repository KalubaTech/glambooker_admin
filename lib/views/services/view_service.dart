import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/controllers/bookings_controller.dart';
import 'package:glambooker_admin/controllers/salon_controller.dart';
import 'package:glambooker_admin/controllers/services_controller.dart';
import 'package:glambooker_admin/customs/kalubtn.dart';
import 'package:glambooker_admin/utils/colors.dart';
import 'package:glambooker_admin/views/payment/checkout.dart';

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
        title: Container(),
        actions: [
          PopupMenuButton(
            color: Karas.background,
              itemBuilder: (c){
                return [
                  PopupMenuItem(child: Text('Edit')),
                  PopupMenuItem(child: Text('Delete')),
                ];
              }
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
