import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/controllres/firebase/farebase_hepler.dart';
import 'package:shop_fusion/models/cart_model.dart';
import 'package:shop_fusion/models/order_model.dart';
import 'package:shop_fusion/screens/user_panel/check_out_screen.dart';
import 'package:shop_fusion/screens/user_panel/rating_screen.dart';
import 'package:shop_fusion/utils/compenents/custom_drawer.dart';

import '../../controllres/firebase/cart_total_price_controller.dart';
class Allorders extends StatefulWidget {
  const Allorders({super.key});

  @override
  State<Allorders> createState() => _AllordersState();
}

class _AllordersState extends State<Allorders> {
  CustomDrawer drawer=CustomDrawer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('All Orders'),
      ),
      body: StreamBuilder(
        stream: FireBaseHelper.fetchAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Orders found.'));
          } else {

            List<OrdersModel> orderModels = snapshot.data!;
            return ListView.builder(
              itemCount: orderModels.length,
              itemBuilder: (context, index) {
                OrdersModel orderModel=orderModels[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  height: Get.height / 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13)
                  ),
                  child:Card(
                    elevation: 2,
                    child: ListTile(
                      leading:  CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.green,
                        backgroundImage:CachedNetworkImageProvider(orderModel.productImages) ,
                      ),
                      title:  Text(orderModel.productName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(orderModel.productFullPrice.toString()),
                          SizedBox(width: Get.width / 25,),
                          orderModel.status?const Text('Delivered',style: TextStyle(color: Colors.green,fontSize: 15),):
                          const Text('On the way..',style: TextStyle(color: Colors.green,fontSize: 15),)
                        ],
                      ),
                      trailing: ElevatedButton(onPressed: (){
                        Get.to(RatingScreen(ordersModel: orderModel,));
                      },
                          child:const Text('Review',style: TextStyle(fontSize: 16),)),
                    ),
                  ),
                );
              },
            );
          }
        },),

    );
  }

}
