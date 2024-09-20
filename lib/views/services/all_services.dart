import 'package:flutter/material.dart';
import 'package:glambooker_admin/controllers/services_controller.dart';
import 'package:glambooker_admin/customs/service_home_container.dart';
import 'package:glambooker_admin/models/service_model.dart';
import 'package:glambooker_admin/utils/colors.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/views/services/add_service.dart';

class AllServices extends StatelessWidget {
  const AllServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Karas.background,
      appBar: AppBar(
        backgroundColor: Karas.background,
        title: Text('Services'),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>AddService(), transition: Transition.fadeIn);
          }, icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        child: GetBuilder<ServicesController>(
            builder: (servicesController){
              List<ServiceModel>_services=servicesController.services.value;
              return GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                ),
                children: [
                  ... _services.map((service){
                    return ServiceHomeContainer(serviceModel: service);
                  })
                ],
              );
            }
        ),
      ),
    );
  }
}
