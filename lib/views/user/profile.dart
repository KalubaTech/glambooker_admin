import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/controllers/client_controller.dart';
import 'package:glambooker_admin/utils/colors.dart';

import '../../models/client_model.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  ClientController _clientController = Get.find();

  @override
  Widget build(BuildContext context) {
    ClientModel client = _clientController.client.value;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Karas.background,
        title: Text('Profile'),
      ),
      backgroundColor: Karas.background,
      body: Container(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person,),
              title: Text('${client.name}'),
              subtitle: Text('Name'),
            ),
            ListTile(
              leading: Icon(Icons.email,),
              title: Text('${client.email}'),
              subtitle: Text('Email'),
            ),
            ListTile(
              leading: Icon(Icons.phone_android,),
              title: Text('${client.phone}'),
              subtitle: Text('Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}
