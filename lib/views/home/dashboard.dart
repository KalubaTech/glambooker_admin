import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/controllers/bookings_controller.dart';
import 'package:glambooker_admin/controllers/client_controller.dart';
import 'package:glambooker_admin/controllers/services_controller.dart';
import 'package:glambooker_admin/customs/kalubtn.dart';
import 'package:glambooker_admin/customs/service_home_container.dart';
import 'package:glambooker_admin/customs/sidemenu_item.dart';
import 'package:glambooker_admin/helpers/auth_service.dart';
import 'package:glambooker_admin/models/service_model.dart';
import 'package:glambooker_admin/utils/colors.dart';
import 'package:glambooker_admin/views/salon/salon.dart';
import 'package:glambooker_admin/views/services/all_services.dart';
import 'package:glambooker_admin/views/services/bookings.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../clients/clients.dart';
import '../user/profile.dart';


class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  GlobalKey<ScaffoldState>_sk = GlobalKey();

  AuthService _authService = AuthService();

  ClientController _clientController = Get.find();

  ServicesController _servicesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      key: _sk,
        appBarColor: Colors.white,
        drawer: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                 fit: BoxFit.cover,
                image: AssetImage('assets/backg.webp')
            ),
            color: Karas.background,
            borderRadius: BorderRadius.only(topRight: Radius.circular(40))
          ),
          width: MediaQuery.of(context).size.width*0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Text('${_clientController.client.value.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Karas.primary),),
              ),
              Expanded(
                  child: Container(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SidemenuItem(
                            title: 'Salon',
                            icon: Icons.place,
                            onclick: ()=>Get.to(()=>Salon(), transition: Transition.fadeIn),
                        ),
                        GetBuilder<BookingsController>(
                          builder: (bookingsController) {
                            return SidemenuItem(
                                title: 'My Bookings',
                                trailText: '${bookingsController.bookings.value.length==0?'':bookingsController.bookings.length}',
                                icon: Icons.book_online,
                                onclick: ()=>Get.to(()=>Bookings(), transition: Transition.fadeIn),
                            );
                          }
                        ),
                        SidemenuItem(
                            title: 'Profile',
                            icon: Icons.person,
                            onclick: ()=>Get.to(()=>Profile(), transition: Transition.fadeIn),
                        ),
                      ],
                    ),
                  )
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Kalubtn(
                    backgroundColor: Karas.action2,
                    borderRadius: 40,
                    width: 100,
                    label: 'Log out',
                    onclick: (){
                      _authService.signOut();
                    }
                ),
              ),
              SizedBox(height: 70,)
            ],
          ),
        ),
        title: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.webp'),
                )
              ],
            ),
          ),
        ),
        headerWidget: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        child: Image.asset('assets/menu_icon.png', width: 24,),
                      ),
                      CircleAvatar(
                        child: Icon(Icons.notifications),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Good Morning!'),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('GLAMBOOKER CMS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Karas.primary),),
                ),
                SizedBox(height: 10,),
               /* Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(),
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(width: 10,),
                                Text('Search', style: TextStyle(color: Colors.grey),)
                              ],
                            ),
                          )
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Karas.action2
                        ),
                        child: Image.asset('assets/config.png', width: 24,),
                      )
                    ],
                  ),
                )*/
              ],
            ),
          ),
        ),
        headerExpandedHeight: 0.18,
        body: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Content', style: TextStyle(fontSize: 20, color: Karas.primary),),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: GridView(
              addRepaintBoundaries: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                InkWell(
                  onTap: (){
                    Get.to(()=>AllServices(), transition: Transition.fadeIn);
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 10,),
                        Icon(FeatherIcons.shoppingCart, size: 60,color: Karas.primary,),
                        Text('SERVICES', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(()=>Bookings(), transition: Transition.fadeIn);
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 10,),
                        Icon(FeatherIcons.bookmark, size: 60,color: Karas.primary,),
                        Text('BOOKINGS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(()=>Clients(), transition: Transition.fadeIn);
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 10,),
                        Icon(FeatherIcons.users, size: 60,color: Karas.primary,),
                        Text('CUSTOMERS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 10,),
                        Icon(FeatherIcons.settings, size: 60,color: Karas.primary,),
                        Text('SETTINGS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,)
        ]
    );
  }
}
