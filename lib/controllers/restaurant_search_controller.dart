// restaurant_search_controller.dart
import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_list_model.dart';
import 'package:get/get.dart';

class RestaurantSearchController extends GetxController {
  final RestaurantApiService _apiService = RestaurantApiService();
  final RxList<Restaurant> _searchResults = RxList<Restaurant>();
  final RxBool _isLoading = RxBool(false);
  final RxBool _hasError = RxBool(false);

  // Use RxString for searchController
  final Rx<String> searchController = Rx<String>('');

  List<Restaurant> get searchResults => _searchResults;
  RxBool get isLoading => _isLoading;
  RxBool get hasError => _hasError;

  @override
  void onInit() {
    ever(searchController, (_) {
      if (searchController.value.isNotEmpty) {
        searchRestaurants(searchController.value);
      } else {
        _searchResults.clear();
      }
    });

    super.onInit();
  }

  Future<void> searchRestaurants(String query) async {
    try {
      _isLoading.value = true;
      _hasError.value = false;

      final results = await _apiService.searchRestaurants(query);
      _searchResults.assignAll(results);
    } catch (e) {
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }
}
