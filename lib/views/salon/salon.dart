import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/controllers/salon_controller.dart';
import 'package:glambooker_admin/controllers/services_controller.dart';
import 'package:glambooker_admin/models/salon_model.dart';
import 'package:glambooker_admin/models/service_model.dart';
import 'package:glambooker_admin/utils/colors.dart';

class Salon extends StatelessWidget {
  Salon({super.key});

  SalonController _salonController = Get.find();

  @override
  Widget build(BuildContext context) {
    SalonModel salon = _salonController.salon.first;
    return Scaffold(
      backgroundColor: Karas.background,
      appBar: AppBar(
        backgroundColor: Karas.background,
        title: Text('Salon'),
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                border: BorderDirectional(top: BorderSide(color: Colors.white))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name', style: TextStyle(fontSize: 10),),
                  Row(
                    children: [
                      Text('${salon.salonName}', style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  border: BorderDirectional(top: BorderSide(color: Colors.white))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address', style: TextStyle(fontSize: 10),),
                  Row(
                    children: [
                      Text('${salon.address}', style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  border: BorderDirectional(top: BorderSide(color: Colors.white))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email', style: TextStyle(fontSize: 10),),
                  Row(
                    children: [
                      Text('${salon.email}', style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  border: BorderDirectional(top: BorderSide(color: Colors.white))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phone', style: TextStyle(fontSize: 10),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${salon.phone}', style: TextStyle(fontSize: 18),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.phone, color: Colors.green,))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  border: BorderDirectional(top: BorderSide(color: Colors.white))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Services', style: TextStyle(fontSize: 10),),
                  SizedBox(height: 20,),
                  GetBuilder<ServicesController>(
                    builder: (servicesController) {
                      List<ServiceModel>services=servicesController.services.value;
                      return Container(
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ListView.builder(
                              itemCount: servicesController.services.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (c,i){
                                ServiceModel service = services[i];
                                return Container(
                                  child: Image.asset('${service.imageUrl}'),
                                );
                              }
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
