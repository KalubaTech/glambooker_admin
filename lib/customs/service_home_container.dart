import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/utils/colors.dart';
import 'package:glambooker_admin/views/services/view_service.dart';

import '../models/service_model.dart';

class ServiceHomeContainer extends StatelessWidget {
  ServiceModel serviceModel;
  ServiceHomeContainer({required this.serviceModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
      onTap: (){
        Get.to(()=>ViewService(serviceModel: serviceModel), transition: Transition.fadeIn);
      },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey,
            borderRadius: BorderRadius.circular(12)
          ),
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: serviceModel.imageUrl,
                  errorWidget: (c,e,i)=>Image.asset(serviceModel.imageUrl, width: double.infinity, height: double.infinity,fit: BoxFit.cover,),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: InkWell(
                  borderRadius: BorderRadius.circular(7),
                  onTap: (){
                    Get.to(()=>ViewService(serviceModel: serviceModel), transition: Transition.fadeIn);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Karas.background,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Text('${serviceModel.title}', textAlign: TextAlign.center,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      color: Karas.background,
    );
  }
}
