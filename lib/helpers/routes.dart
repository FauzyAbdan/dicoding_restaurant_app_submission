// routes.dart
import 'package:dicoding_restaurant_app_submission/controllers/restaurant_list_controller.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_detail.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_favorite.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_list.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_search.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_setting.dart';
import 'package:get/get.dart';

class Routes {
  static final home = GetPage(
    name: '/',
    page: () => const RestaurantList(),
  );
  static final detail = GetPage(
    name: '/detail',
    page: () => DetailRestaurant(Get.arguments.toString()),
  );
  static final search = GetPage(
    name: '/search',
    page: () => RestaurantSearch(),
  );
  static final favorite = GetPage(
    name: '/favorite',
    page: () => const RestaurantFavorite(),
  );
  static final setting = GetPage(
    name: '/setting',
    page: () => GetBuilder<RestaurantListController>(
      init: RestaurantListController(), // Inisialisasi controller
      builder: (controller) {
        return RestaurantSetting(restaurants: controller.restaurants);
      },
    ),
  );
}
