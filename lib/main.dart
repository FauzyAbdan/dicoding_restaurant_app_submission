import 'package:dicoding_restaurant_app_submission/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_list.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dicoding Restaurant App Submission 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: RestaurantList(),
      ),
      getPages: [
        Routes.home,
        Routes.detail,
        Routes.bookmark,
        Routes.search,
      ],
    );
  }
}
