//restaurant_favorite_controller.dart
import 'package:get/get.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_favorite_model.dart';
import 'package:dicoding_restaurant_app_submission/helpers/database_helper.dart';

class RestaurantFavoriteController extends GetxController {
  final RxList<FavoriteRestaurant> _favoriteRestaurants =
      RxList<FavoriteRestaurant>();

  List<FavoriteRestaurant> get favoriteRestaurants => _favoriteRestaurants;

  final FavoriteDatabaseHelper _databaseHelper = FavoriteDatabaseHelper();

  Future<void> loadFavoriteRestaurants() async {
    List<Map<String, dynamic>> maps =
        await FavoriteDatabaseHelper.getAllFavoriteRestaurants();
    _favoriteRestaurants.value =
        maps.map((item) => FavoriteRestaurant.fromMap(item)).toList();
  }

  Future<void> addToFavorite(FavoriteRestaurant favoriteRestaurant) async {
    await _databaseHelper.insertFavoriteRestaurant(favoriteRestaurant);
    await loadFavoriteRestaurants();
    update();
  }

  Future<void> removeFromFavorite(String id) async {
    await _databaseHelper.deleteFavoriteRestaurant(id);
    await loadFavoriteRestaurants();
    update();
  }

  Future<void> toggleFavorite(FavoriteRestaurant favoriteRestaurant) async {
    if (favoriteRestaurants.contains(favoriteRestaurant)) {
      await removeFromFavorite(favoriteRestaurant.id);
    } else {
      await addToFavorite(favoriteRestaurant);
    }
  }
}
