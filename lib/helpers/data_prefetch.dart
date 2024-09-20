import 'package:get/get.dart';
import 'package:glambooker_admin/controllers/bookings_controller.dart';
import 'package:glambooker_admin/controllers/salon_controller.dart';
import 'package:glambooker_admin/controllers/services_controller.dart';
import 'package:glambooker_admin/models/booking_model.dart';
import 'package:glambooker_admin/statics/dummy_data.dart';

class DataPrefetch {
  ServicesController _servicesController = Get.find();
  SalonController _salonController = Get.find();
  BookingsController _bookingsController = Get.find();

  void fetchAllServices()async{
     _servicesController.services.value = DummyData.DUMMY_SERVICES;
     _servicesController.update();
  }

  void fetchSalon()async{
    _salonController.salon.value = [DummyData.SALON_DATA];
  }

  void fetchBookings()async{
    _bookingsController.bookings.value = [];
  }

}