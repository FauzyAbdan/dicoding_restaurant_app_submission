//main.dart
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:dicoding_restaurant_app_submission/controllers/restaurant_favorite_controller.dart';
import 'package:dicoding_restaurant_app_submission/helpers/routes.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_list.dart';
import 'package:dicoding_restaurant_app_submission/utility/restaurant_notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi plugin notifikasi
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
  );

  // Memuat restoran favorit
  RestaurantFavoriteController controller =
      Get.put(RestaurantFavoriteController());
  controller.loadFavoriteRestaurants();

  runApp(
    GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        // Memuat restoran favorit
        controller.loadFavoriteRestaurants();
      }),
      debugShowCheckedModeBanner: false,
      title: 'Dicoding Restaurant App Submission 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const RestaurantList(),
      getPages: [Routes.detail, Routes.search, Routes.favorite, Routes.setting],
      defaultTransition: Transition.native,
    ),
  );

  // Jadwalkan notifikasi harian
  scheduleDailyNotification([]);
}
