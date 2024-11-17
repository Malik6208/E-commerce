import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:shop_fusion/screens/user_panel/categories_details_Screen.dart';

import '../../controllres/firebase/farebase_hepler.dart';
class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories'),
      ),
      body:FutureBuilder<List<Map<String, dynamic>>>(
        future: FireBaseHelper.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: Get.height/5,
                child: const Center(child: CupertinoActivityIndicator()));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Users Found'));
          }else{
            return GridView.builder(
              itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,mainAxisSpacing:2,
                crossAxisSpacing: 2
                ),
                itemBuilder: (context, index) {
                  var category=snapshot.data![index];
                  return GestureDetector(
                    onTap: (){
                      Get.to(CategoriesDetailsScreen(details: category,));
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: FillImageCard(

                            width: Get.width/2.4,
                            heightImage: Get.height/10,
                            borderRadius:20,
                            imageProvider:CachedNetworkImageProvider(
                              category['categoryImg'],
                            ),
                            title: Text(category['categoryName'].toString()),
                            description: Text('data'),
                          ),
                        )
                      ],
                    ),
                  );

                },
            );
          }
        },
      ) ,
    );
  }
}
