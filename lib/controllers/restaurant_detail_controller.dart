import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_detail_model.dart';
import 'package:get/get.dart';

class RestaurantDetailController extends GetxController {
  final RestaurantApiService _apiService = RestaurantApiService();
  final Rx<RestaurantDetail?> _restaurantDetail = Rx(null);
  final RxBool _hasError = RxBool(false);

  RestaurantDetail? get restaurantDetail => _restaurantDetail.value;
  bool get hasError => _hasError.value;

  Future<void> fetchRestaurantDetails(String restaurantId) async {
    try {
      final restaurantDetail =
          await _apiService.fetchRestaurantDetails(restaurantId);
      _restaurantDetail.value = restaurantDetail;
      _hasError.value = false;
    } catch (e) {
      // Handle error
      _hasError.value = true;
    }
  }
}
