import 'package:glambooker_admin/models/service_model.dart';

class BookingModel {
  String client;
  String bookingId;
  List<ServiceModel> service;
  bool isPaid;
  String status;
  String dateTime;
  String dateBooked;

  BookingModel(
    {
      required this.client,
      required this.bookingId,
      required this.service,
      required this.isPaid,
      required this.status,
      required this.dateTime,
      required this.dateBooked
    }
  );
}