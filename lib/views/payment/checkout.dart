import 'package:flutter/material.dart';
import 'package:glambooker/controllers/bookings_controller.dart';
import 'package:glambooker/customs/kalubtn.dart';
import 'package:glambooker/helpers/methods.dart';
import 'package:glambooker/models/booking_model.dart';
import 'package:glambooker/statics/dummy_data.dart';
import 'package:glambooker/utils/colors.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../models/service_model.dart';

class Checkout extends StatelessWidget {

  ServiceModel service;
  DateTime dateTime;
  Checkout({required this.service, required this.dateTime});


  var selectedOption = Container().obs;
  var selectedProvider = 0.obs;

  var isPaymentVerifying = false.obs;

  Methods _methods = Methods();

  @override
  Widget build(BuildContext context) {
    selectedOption.value = Container(
      child: _methods.paymentOptionDisplay(DummyData.paymentOptions[selectedProvider.value]),
    );
    return Scaffold(
      backgroundColor: Karas.background,
      appBar: AppBar(
        backgroundColor: Karas.primary,
        foregroundColor: Karas.background,
        titleSpacing: 0,
        title: Text("Make payment", style: TextStyle(fontSize: 19),),
      ),
      body: GetBuilder<BookingsController>(
        builder: (bookingController) {
          List<BookingModel> bookings = bookingController.bookings;
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Karas.secondary,
                    border: Border.all(
                      color: Colors.white
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Obx(
                              ()=>Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  selectedOption.value
                                ],
                              ),
                            ),
                          )
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                selectedProvider.value = 0;
                                selectedOption.value = Container(
                                  child: _methods.paymentOptionDisplay(DummyData.paymentOptions[selectedProvider.value]),
                                );
                              },
                              child: Obx(
                                    ()=> Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                      border:  selectedProvider.value==0?Border.all(color: Karas.primary, width: 2):Border.all(color: Colors.transparent),
                                    image: DecorationImage(
                                       fit: BoxFit.cover,
                                        image: AssetImage('assets/airtel.jpg')
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child:  InkWell(
                              onTap: (){
                                selectedProvider.value = 1;

                                selectedOption.value = Container(
                                  child: _methods.paymentOptionDisplay(DummyData.paymentOptions[selectedProvider.value]),
                                );

                              },
                              child: Obx(
                                ()=> Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                      border:  selectedProvider.value==1?Border.all(color: Karas.primary, width: 2):Border.all(color: Colors.transparent),
                                    image: DecorationImage(
                                       fit: BoxFit.cover,
                                        image: AssetImage('assets/mtn.png')
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child:  InkWell(
                              onTap: (){
                                selectedProvider.value = 2;

                                selectedOption.value = Container(
                                  child: _methods.paymentOptionDisplay(DummyData.paymentOptions[selectedProvider.value]),
                                );

                              },
                              child: Obx(
                                ()=> Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                    border:  selectedProvider.value==2?Border.all(color: Karas.primary, width: 2):Border.all(color: Colors.transparent),
                                    image: DecorationImage(
                                       fit: BoxFit.cover,
                                        image: AssetImage('assets/zamtel.png')
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),
                      SizedBox(height: 14,)
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      child: Obx(
                        ()=> isPaymentVerifying.value?Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingAnimationWidget.threeArchedCircle(color: Colors.orange, size: 40),
                            SizedBox(height: 20,),
                            Text('Verifying payment...')
                          ],
                        ):Container(),
                      ),
                    )
                ),

                Obx(()=> Container(
                    child: isPaymentVerifying.value?Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: Karas.secondary,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Waiting for payment confirmation by the Salon Admin.', textAlign: TextAlign.center,),
                    ):Kalubtn(
                      borderRadius: 40,
                      backgroundColor: Colors.green,
                      height: 45,
                        label: 'Complete Book',
                        onclick: (){
                        //  isPaymentVerifying.value = true;

                          String id = '12345';
                          BookingModel _booking = BookingModel(
                              bookingId: id,
                              service: [service],
                              isPaid: true,
                              status: 'pending',
                              dateTime: dateTime,
                              dateBooked: DateTime.now()
                          );

                          Get.defaultDialog(
                            title: 'Confirm Booking',
                            titleStyle: TextStyle(fontSize: 14, color: Karas.primary, fontWeight: FontWeight.bold),
                            content: Container(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: Image.asset(
                                            _booking.service.first.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(_booking.service.first.title, style: TextStyle(fontWeight: FontWeight.bold),),
                                                Text('K${_booking.service.first.price}'),
                                                SizedBox(height: 20,),
                                                Kalubtn(
                                                    width: 200,
                                                    label: 'Confirm',
                                                    onclick: (){
                                                      bookingController.bookings.add(_booking);
                                                      bookingController.update();
                                                      Get.back();
                                                    }
                                                ),
                                                SizedBox(height: 20,)
                                              ],
                                            ),
                                          )
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          );
                          /*
                          *
                          * */
                        }
                    ),
                  ),),
                SizedBox(height: 20,),
                Obx(()=> Container(
                    child: isPaymentVerifying.value?Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Waiting for payment confirmation by the Salon Admin.', textAlign: TextAlign.center,),
                    ):Kalubtn(
                      borderRadius: 40,
                      height: 45,
                        backgroundColor: Colors.orange,
                        label: 'Continue Without Payment',
                        onclick: (){
                          isPaymentVerifying.value = true;
                        }
                    ),
                  ),),
                SizedBox(height: 20,)
              ],
            ),
          );
        }
      ),
    );
  }
}
