// routes.dart
import 'package:dicoding_restaurant_app_submission/screens/restaurant_bookmarked.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_detail.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_list.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_search.dart';
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
  static final bookmark = GetPage(
    name: '/bookmarked',
    page: () => const RestaurantBookmarked(),
  );
}
