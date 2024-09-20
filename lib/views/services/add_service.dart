import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glambooker_admin/customs/kalubtn.dart';
import 'package:glambooker_admin/customs/kalutext.dart';
import 'package:glambooker_admin/helpers/methods.dart';
import 'package:glambooker_admin/utils/colors.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddService extends StatelessWidget {
  AddService({super.key});

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  File? imageUrl;


  var isLoading = false.obs;

  Methods _methods = Methods();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Service'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            ImagePickerWidget(
              diameter: 150,
              initialImage: "assets/placeholder_image.webp",
              shape: ImagePickerWidgetShape.square, // ImagePickerWidgetShape.square
              isEditable: true,
              borderRadius: Radius.circular(10),
              editIcon: Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                     backgroundColor: Colors.black45,
                    child: Icon(Icons.add_photo_alternate_outlined, color: Karas.secondary,)
                ),
              ),
              onChange: (File file) {
               // print("I changed the file to: ${file.path}");
                imageUrl = file;
              },
            ),
            SizedBox(height: 20,),
            Kalutext(
                controller: _titleController,
                hintText: 'Title',
                labelText: 'Title',
                border: Border.all(color: Karas.primary),
            ),
            SizedBox(height: 20,),
            Kalutext(
                controller: _priceController,
                hintText: 'Price',
                labelText: 'Price',
                isNumber: true,
              border: Border.all(color: Karas.primary),
            ),
            SizedBox(height: 20,),
            Kalutext(
              controller: _descriptionController,
              hintText: 'Description',
              labelText: 'Description',
              isNumber: false,
              border: Border.all(color: Karas.primary),
            ),
            SizedBox(height: 30,),
            Obx(
                ()=> isLoading.value?
                Container(
                  width: double.infinity,
                  child: Center(child: LoadingAnimationWidget.inkDrop(color: Karas.primary, size: 40)),
                ):
                Kalubtn(
                height: 45,
                  label: 'SAVE',
                  onclick: ()async{
                    if(_titleController.text.isNotEmpty && _priceController.text.isNotEmpty && imageUrl!=null){
                      isLoading.value = true;
                      await _methods.addService(
                          imageUrl,
                          _titleController.text,
                          _descriptionController.text,
                          _priceController.text
                      );
                      Fluttertoast.showToast(msg: 'Added Successfully!');
                      _titleController.clear();
                      _descriptionController.clear();
                      _priceController.clear();
                     isLoading.value = false;
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
