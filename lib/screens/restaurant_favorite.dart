//restaurant_favorite.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dicoding_restaurant_app_submission/controllers/restaurant_favorite_controller.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_favorite_model.dart';
import 'package:dicoding_restaurant_app_submission/helpers/random_restaurant_of_the_month.dart';
import 'package:dicoding_restaurant_app_submission/widgets/bottom_navigation_bar.dart';
import 'package:dicoding_restaurant_app_submission/widgets/favorite_restaurant_list_tile.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_rating.dart';

class RestaurantFavorite extends StatelessWidget {
  const RestaurantFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RestaurantFavoriteController restaurantFavoriteController =
        Get.put(RestaurantFavoriteController());

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: const Color.fromARGB(141, 1, 16, 16),
            elevation: 0.2,
            pinned: true,
            floating: true,
            expandedHeight: 240,
            flexibleSpace: FlexibleSpaceBar(
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Text(
                        "MY FAVORITE",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              titlePadding: const EdgeInsets.only(left: 30, bottom: 16),
              background: Image(
                image: AssetImage(getRandomImage()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          GetBuilder<RestaurantFavoriteController>(
            init: restaurantFavoriteController,
            builder: (RestaurantFavoriteController controller) {
              return Obx(() {
                final favoriteRestaurants = controller.favoriteRestaurants;

                if (favoriteRestaurants.isEmpty) {
                  return const SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.book_outlined,
                              size: 40, color: Colors.amber),
                          SizedBox(height: 8),
                          Text(
                            'Your favorite restaurants will be displayed here.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final favoriteRestaurant = favoriteRestaurants[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('detail',
                                arguments: favoriteRestaurant.id);
                          },
                          child: buildFavoriteRestaurantList(
                              context, favoriteRestaurant),
                        );
                      },
                      childCount: favoriteRestaurants.length,
                    ),
                  );
                }
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget buildRestaurantList(
      BuildContext context, FavoriteRestaurant restaurant) {
    String imageUrl =
        'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed('detail', arguments: restaurant.id);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Hero(
              tag: "restaurant_image_${restaurant.pictureId}",
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ),
            title: Text(restaurant.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurant.city),
                RestaurantRating(rating: restaurant.rating),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                Get.find<RestaurantFavoriteController>()
                    .removeFromFavorite(restaurant.id);
              },
            ),
          ),
        ),
      ),
    );
  }
}
