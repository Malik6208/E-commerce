import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_fusion/models/cart_model.dart';
import 'package:shop_fusion/models/category_model.dart';
import 'package:shop_fusion/screens/user_panel/product_detailas_screen.dart';

import '../../models/order_model.dart';
import '../../models/user_model.dart';

class FireBaseHelper {
 static User? user=FirebaseAuth.instance.currentUser;
 static final FirebaseFirestore _db = FirebaseFirestore.instance;

 static Future<List<Map<String, dynamic>>> getCategories() async {
   QuerySnapshot snapshot = await _db.collection('categories').get();
   return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
 }

 static Future<List<Map<String, dynamic>>> getProducts() async {
   QuerySnapshot snapshot = await _db.collection('products').get();
   return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
 }

static Stream<List<CartModel>> fetchOrderCarts() {
   return FirebaseFirestore.instance
       .collection('Carts').doc(user!.uid).collection('cartOrders') // Change 'items' to your collection name
       .snapshots()
       .map((snapshot) =>
       snapshot.docs.map((doc) => CartModel.fromJson(doc.data())).toList());
 }
 static Future<UserModel?> getUser() async {
   try {
     DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
         .collection('users')
         .doc(user!.uid)
         .get();

     if (doc.exists) {
       return UserModel.fromJson(doc.data()!, );
     }
     return null;
   } catch (e) {
     print('Error fetching user: $e');
     return null;
   }
 }
 static Stream<List<OrdersModel>> fetchAllOrders() {
   return FirebaseFirestore.instance
       .collection('orders').doc(user!.uid).collection('confirmOrders') // Change 'items' to your collection name
       .snapshots()
       .map((snapshot) =>
       snapshot.docs.map((doc) => OrdersModel.fromJson(doc.data())).toList());
 }


static Future<UserModel?> fetchUserProfilePic() async {
   try {
     // Reference the user's document
     DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
         .collection('users') // Replace with your collection name
         .doc(user!.uid) // Pass the user's unique ID
         .get();

     if (snapshot.exists) {
       // Convert the data to your UserProfile model
       return UserModel.fromJson(snapshot.data()!);
     } else {
       print('User does not exist');
       return null;
     }
   } catch (e) {
     print('Error fetching userProfilePic: $e');
     return null;
   }
 }


}