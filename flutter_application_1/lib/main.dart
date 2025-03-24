import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_application_1/screens/liked/liked_screen.dart';
import 'package:flutter_application_1/screens/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => child!,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: Colors.white),
        getPages: [
          GetPage(
            name: '/',
            page: () => SplashScreen(),
          ),
          GetPage(
            name: '/home',
            page: () => HomeScreen(),
          ),
          GetPage(
            name: '/liked',
            page: () => LikedScreen(),
          ),
        ],
      ),
    );
  }
}
