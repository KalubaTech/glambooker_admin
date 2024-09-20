import 'package:get/get.dart';
import 'package:glambooker_admin/models/client_model.dart';

class ClientController extends GetxController{
  var client = ClientModel(uid: '', email: '', name: '', phone: '', picture: '').obs;
}