//restaurant_list_tile.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_favorite_model.dart';
import 'package:dicoding_restaurant_app_submission/controllers/restaurant_favorite_controller.dart';

Widget buildFavoriteRestaurantList(
    BuildContext context, FavoriteRestaurant restaurants) {
  String imageUrl =
      'https://restaurant-api.dicoding.dev/images/small/${restaurants.pictureId}';
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Hero(
            tag: "restaurant_image_${restaurants.pictureId}",
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(imageUrl),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              width: 150,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 6, left: 10.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        restaurants.name.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      textAlign: TextAlign.justify,
                      restaurants.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: RestaurantRating(rating: restaurants.rating)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: Obx(
                        () {
                          final controller =
                              Get.find<RestaurantFavoriteController>();
                          final isFavorite = controller.favoriteRestaurants.any(
                              (restaurant) => restaurant.id == restaurants.id);

                          return GestureDetector(
                            onTap: () {
                              if (isFavorite) {
                                controller.removeFromFavorite(restaurants.id);
                              } else {
                                controller.addToFavorite(
                                  FavoriteRestaurant(
                                    id: restaurants.id,
                                    name: restaurants.name,
                                    description: restaurants.description,
                                    pictureId: restaurants.pictureId,
                                    city: restaurants.city,
                                    rating: restaurants.rating,
                                  ),
                                );
                              }
                            },
                            child: Icon(
                              isFavorite
                                  ? Icons.delete
                                  : Icons.bookmark_outline,
                              color: isFavorite ? Colors.red : Colors.amber,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
