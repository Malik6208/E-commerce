import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickImageController {
  File? _image; // To store the selected image
  final ImagePicker _picker = ImagePicker(); // Create an instance of ImagePicker

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
          _image = File(pickedFile.path);// Convert XFile to File
    String url=   await uploadImageToFireStore();
     await updateUserImg(url);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<String> uploadImageToFireStore() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      Reference ref = storage.ref().child('images/${DateTime
          .now()
          .millisecondsSinceEpoch}.jpg');

      // Step 3: Upload the file
      UploadTask uploadTask = ref.putFile(_image!);

      // Step 4: Wait for upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Step 5: Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print('Uploaded image URL: $downloadUrl');
      return downloadUrl;
    }
    catch (e) {
      print('Error uploading image: $e');
    }
    return '';
  }

  Future<void> updateUserImg(String url) async {
   try{
     User? user=FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.
     collection('users').doc(user!.uid).update({
       'userImg':url,
     });
   }catch (e){
     print(e.toString());
   }
  }
}



