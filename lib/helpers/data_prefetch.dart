import 'package:get/get.dart';
import 'package:glambooker_admin/controllers/bookings_controller.dart';
import 'package:glambooker_admin/controllers/salon_controller.dart';
import 'package:glambooker_admin/controllers/services_controller.dart';
import 'package:glambooker_admin/models/booking_model.dart';
import 'package:glambooker_admin/statics/dummy_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/service_model.dart';

class DataPrefetch {
  ServicesController _servicesController = Get.find();
  SalonController _salonController = Get.find();
  BookingsController _bookingsController = Get.find();

  FirebaseFirestore _fs = FirebaseFirestore.instance;

  void fetchAllServices()async{
    
     List<ServiceModel>_services=[];

      var data = await _fs.collection('services').get();
      
      for(var doc in data.docs){
        ServiceModel service = ServiceModel(
            uid: doc.id, 
            title: doc.get('title'), 
            description: doc.get('description'), 
            imageUrl: doc.get('image'), 
            price: double.parse(doc.get('price'))
        );
        
        _services.add(service);
      }
      

     _servicesController.services.value = _services;
     _servicesController.update();
  }

  void fetchSalon()async{
    _salonController.salon.value = [DummyData.SALON_DATA];
  }

  void fetchBookings()async{
     List<BookingModel>bookings=[];

     var bookingData = await _fs.collection('bookings').get();

     for(var doc in bookingData.docs){

       ServiceModel service = _servicesController.services.where((s)=>s.uid==doc.get('service')).first;

       BookingModel booking = BookingModel(
           bookingId: doc.id,
           service: [service],
           isPaid: doc.get('isPaid'),
           status: doc.get('status'),
           dateTime: doc.get('dateTime'),
           dateBooked: doc.get('dateBooked')
       );

       bookings.add(booking);
     }

    _bookingsController.bookings.value = bookings;

     _bookingsController.update();
  }

}