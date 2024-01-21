// restaurant_list_controller.dart
import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_list_model.dart';
import 'package:get/get.dart';

class RestaurantListController extends GetxController {
  final RestaurantApiService _apiService = RestaurantApiService();
  final RxList<Restaurant> _restaurants = RxList<Restaurant>();
  final RxBool _hasError = RxBool(false);

  List<Restaurant> get restaurants => _restaurants;
  bool get hasError => _hasError.value;

  @override
  void onInit() {
    super.onInit();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    try {
      _restaurants.assignAll(await _apiService.fetchRestaurants());
      _hasError.value = false; // Reset error status on successful fetch
    } catch (e) {
      _hasError.value = true; // Set error status on fetch failure
      // Handle error (optional)
    }
  }
}
