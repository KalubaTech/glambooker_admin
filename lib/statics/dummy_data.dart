

import 'package:get/get.dart';
import 'package:glambooker_admin/controllers/bookings_controller.dart';
import 'package:glambooker_admin/controllers/services_controller.dart';
import 'package:glambooker_admin/models/booking_model.dart';
import 'package:glambooker_admin/models/salon_model.dart';

import '../models/service_model.dart';

class DummyData{

  ServicesController _servicesController = Get.find();

  static var DUMMY_SERVICES = <ServiceModel>[
    ServiceModel(uid: '1', title: 'Hair', description: 'Perfectly all type of hair', imageUrl: 'assets/hair.jpg', price: 500),
    ServiceModel(uid: '2', title: 'Makeup', description: 'Perfectly all type of makeup', imageUrl: 'assets/make_up.jpg', price: 400),
    ServiceModel(uid: '3', title: 'Lashes', description: 'Perfectly all type of lashes', imageUrl: 'assets/lashes.jpg', price: 300),
    ServiceModel(uid: '4', title: 'Nails', description: 'Perfectly all type of nails', imageUrl: 'assets/nails.jpg', price: 800),
    ServiceModel(uid: '5', title: 'Wax', description: 'Perfectly all type of wax', imageUrl: 'assets/wax.jpg', price: 800),
  ];

  static var SALON_DATA = SalonModel(
      salonName: 'Foxdale Salon',
      phone: '0972332244',
      email: 'foxdale@gmail.com',
      logo: '',
      address: '245 Foxdale, Lusaka, Zambia.',
      coverImage: ''
  );

  static List<Map<String, dynamic>> paymentOptions = [
    {
      "provider":"airtel",
      "contact":"0972332233",
      "names":"Lwanga Lwanga"
    },
    {
      "provider":"mtn",
      "contact":"0962332233",
      "names":"Lwanga Lwanga"
    },
    {
      "provider":"zamtel",
      "contact":"0952332233",
      "names":"Lwanga Lwanga"
    },
  ];



  List<ServiceModel>getServices(){
    return _servicesController.services.value.where((service)=>service.uid=='2').toList();
  }
  static var myBookings =  [
    BookingModel(
      client: '',
        bookingId: '2',
        service: [],
        isPaid: false,
        status: 'pending',
        dateTime: DateTime.now().toString(),
        dateBooked: DateTime.now().toString(),
    )
  ];
}