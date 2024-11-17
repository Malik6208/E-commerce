import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:shop_fusion/controllres/firebase/farebase_hepler.dart';
class CoustomProduct extends StatelessWidget {
  const CoustomProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: FireBaseHelper.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: Get.height/5,
              child: const Center(child: CupertinoActivityIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Users Found'));
        }else{
          return Container(
            height: Get.height/5,
            child:ListView.builder(

              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var category=snapshot.data![index];
                return Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Container(

                        child: FillImageCard(
                          width: Get.width/3,
                          heightImage: Get.height/10,
                          borderRadius:20,
                          imageProvider:CachedNetworkImageProvider(
                            category['productImages'],
                          ),
                          title: Text(category['productName'].toString()),
                          footer: Row(
                            children: [
                              Text("Rs ${category['salePrice'].toString()}"),
                             const SizedBox(width: 3.0,),
                              Text(category['fullPrice'].toString(),
                                style: const TextStyle(color: Colors.red,
                                    decoration: TextDecoration.lineThrough),
                              )
                            ],
                          ),
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
