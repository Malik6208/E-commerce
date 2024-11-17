
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/utils/app_constant.dart';
import 'firebase_options.dart';
import 'screens/auth_ui/check_user.dart';
import 'screens/auth_ui/sign_in_screen.dart';
import 'screens/auth_ui/splash_screen.dart';
import 'screens/auth_ui/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstant.appSecondryColor,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        ),
        textTheme: TextTheme(

        ),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

