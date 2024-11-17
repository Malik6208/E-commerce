
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_fusion/screens/auth_ui/sign_in_screen.dart';
import 'package:shop_fusion/screens/auth_ui/welcome_screen.dart';
import 'package:shop_fusion/screens/user_panel/all_categories_screen.dart';
import 'package:shop_fusion/screens/user_panel/all_flash_shale.dart';
import 'package:shop_fusion/screens/user_panel/cart_screen.dart';
import 'package:shop_fusion/utils/compenents/all_products.dart';
import 'package:shop_fusion/utils/compenents/coustom_banners.dart';
import 'package:shop_fusion/utils/compenents/coustom_headline.dart';
import 'package:shop_fusion/utils/compenents/coustom_product.dart';
import 'package:shop_fusion/utils/compenents/custom_drawer.dart';

import '../../utils/app_constant.dart';
import '../../utils/compenents/coustom_category.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: const Text('MainScreen'),
        actions: [
          IconButton(onPressed: (){
            Get.to(const CartScreen());
          },
              icon:const Icon(Icons.add_shopping_cart,size: 30,))
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(

          child: Column(
            children: [
              CoustomBanners(),
              CoustomHeadline(
                  headingTitle: 'Categories',
                  headingSubTitle: 'According to your budget',
                  buttonText: 'See More >', callback: (){
                  Get.to(const AllCategoriesScreen());
              }),
              CoustomCategory(),
              CoustomHeadline(
                  headingTitle: 'Flash Sale',
                  headingSubTitle: 'According to your budget',
                  buttonText: 'See More >', callback: (){
                    Get.to(const AllFlashShale());

              }),
              CoustomProduct(),
              CoustomHeadline(
                  headingTitle: 'All Products',
                  headingSubTitle: 'According to your budget',
                  buttonText: 'See More >', callback: (){
                       Get.to(AllProducts());
              }),

            ],
          ),
        ),
      ),
    );
  }
}
