import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_fusion/controllres/firebase/farebase_hepler.dart';
import 'package:shop_fusion/controllres/image_picker_controller.dart';
import 'package:shop_fusion/models/user_model.dart';
import 'package:shop_fusion/screens/auth_ui/welcome_screen.dart';
import 'package:shop_fusion/utils/app_constant.dart';
import 'package:shop_fusion/utils/utils.dart';
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: Get.height/25),
      child: Drawer(
        backgroundColor: AppConstant.appSecondryColor,
        child:ListView(
          children:  [
            FutureBuilder(future:FireBaseHelper.getUser(),
                builder: (context, snapshot) { if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('User not found'));
                }else {
                  UserModel user = snapshot.data!;
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          leading:Stack(
                            children: [
                              CircleAvatar(

                                backgroundImage:
                                CachedNetworkImageProvider(user.userImg!=null?user.userImg.toString():
                                'https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png'),
                                radius: 40,
                              ),
                              Positioned(

                                child: IconButton(onPressed: (){
                                  Utils.imagePickerDialog(context);
                                },
                                    icon: Icon(Icons.edit,color: Colors.black,size: 35,)),
                                bottom: 0,
                                right: 2,
                                width: Get.width/10,
                              )
                            ],
                          ),
                          title: Text(user.userName.toString(),
                            style: TextStyle(color: AppConstant.appTextColor),),
                          subtitle: Text(user.email.toString(),
                            style: TextStyle(color: AppConstant.appTextColor),),
                        ),
                      ),
                      Divider(
                        thickness: 1.5,
                        color: Colors.grey,
                        endIndent: 10,
                        indent: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: Icon(Icons.home, size: 35,
                            color: AppConstant.appTextColor,),
                          title: Text('Home',
                            style: TextStyle(color: AppConstant.appTextColor),),
                          trailing: Icon(Icons.arrow_forward, size: 30,
                            color: AppConstant.appTextColor,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: Icon(Icons.production_quantity_limits,
                            size: 35, color: AppConstant.appTextColor,),
                          title: Text('Products',
                            style: TextStyle(color: AppConstant.appTextColor),),
                          trailing: Icon(Icons.arrow_forward, size: 30,
                            color: AppConstant.appTextColor,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: Icon(Icons.shopping_bag_rounded, size: 35,
                            color: AppConstant.appTextColor,),
                          title: Text('Shopping',
                            style: TextStyle(color: AppConstant.appTextColor),),
                          trailing: Icon(Icons.arrow_forward, size: 30,
                            color: AppConstant.appTextColor,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: Icon(Icons.contact_support, size: 35,
                            color: AppConstant.appTextColor,),
                          title: Text('Contact',
                            style: TextStyle(color: AppConstant.appTextColor),),
                          trailing: Icon(Icons.arrow_forward, size: 30,
                            color: AppConstant.appTextColor,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: ListTile(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            GoogleSignIn _googleSignIn = GoogleSignIn();
                            await _googleSignIn.signOut();
                            Get.offAll(WelcomeScreen());
                          },
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: Icon(Icons.logout, size: 35,
                            color: AppConstant.appTextColor,),
                          title: Text('Logout',
                            style: TextStyle(color: AppConstant.appTextColor),),
                          trailing: Icon(Icons.arrow_forward, size: 30,
                            color: AppConstant.appTextColor,),
                        ),
                      ),
                    ],
                  );
                }
                },),

          ],
        ),
      ),
    );
  }
}
