import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:shop_fusion/controllres/firebase/farebase_hepler.dart';
class CoustomCategory extends StatelessWidget {
  const CoustomCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
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
            return  SizedBox(
              height: Get.height/5,
              child:ListView.builder(

                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                  var category=snapshot.data![index];
                    return Row(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                            child: FillImageCard(
                              width: Get.width/4,
                              heightImage: Get.height/10,
                              borderRadius:20,
                              imageProvider:CachedNetworkImageProvider(
                                  category['categoryImg'],
                              ),
                              title: Text(category['categoryName'].toString()),
                              description: Text('data'),
                            ),
                          ),
                        )
                      ],
                    );
                  },
              ) ,
            );
          }
        },
    );
  }
}
