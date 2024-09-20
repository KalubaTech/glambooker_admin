import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glambooker_admin/views/pages_anchor.dart';
import 'package:get/get.dart';
import 'controllers/bookings_controller.dart';
import 'controllers/client_controller.dart';
import 'controllers/favourites_controller.dart';
import 'controllers/salon_controller.dart';
import 'controllers/services_controller.dart';
import 'helpers/data_prefetch.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  Get.put(ClientController());
  Get.put(BookingsController());
  Get.put(ServicesController());
  Get.put(FavouritesController());
  Get.put(SalonController());
  DataPrefetch().fetchAllServices();
  DataPrefetch().fetchBookings();
  DataPrefetch().fetchSalon();
  DataPrefetch();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glambooker admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PagesAnchor(),
    );
  }
}
