import 'package:glambooker_admin/models/service_model.dart';

class BookingModel {
  String bookingId;
  List<ServiceModel> service;
  bool isPaid;
  String status;
  DateTime dateTime;
  DateTime dateBooked;

  BookingModel(
    {
      required this.bookingId,
      required this.service,
      required this.isPaid,
      required this.status,
      required this.dateTime,
      required this.dateBooked
    }
  );
}