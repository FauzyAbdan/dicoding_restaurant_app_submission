//restaurant_detail.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dicoding_restaurant_app_submission/widgets/error_loading_restaurant.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_category.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_menu.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_rating.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_review.dart';
import 'package:dicoding_restaurant_app_submission/controllers/restaurant_detail_controller.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_favorite_model.dart';
import 'package:dicoding_restaurant_app_submission/controllers/restaurant_favorite_controller.dart';

class DetailRestaurant extends StatefulWidget {
  final String restaurantId;
  const DetailRestaurant(
    this.restaurantId, {
    super.key,
  });

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  final RestaurantDetailController _restaurantDetailController =
      Get.put(RestaurantDetailController());

  late String imageURL;

  @override
  void initState() {
    super.initState();

    _restaurantDetailController.fetchRestaurantDetails(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final restaurantDetail = _restaurantDetailController.restaurantDetail;

          if (_restaurantDetailController.hasError) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: ErrorLoadingRestaurant()),
                  ],
                ),
              ),
            );
          } else if (restaurantDetail == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final imageURL =
                'https://restaurant-api.dicoding.dev/images/medium/${restaurantDetail.pictureId}';
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: const Color.fromARGB(141, 1, 16, 16),
                    elevation: 0.2,
                    pinned: true,
                    floating: true,
                    expandedHeight: 280,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            restaurantDetail.name.toUpperCase(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Obx(
                              () {
                                final controller =
                                    Get.find<RestaurantFavoriteController>();
                                final isFavorite = controller
                                    .favoriteRestaurants
                                    .any((restaurant) =>
                                        restaurant.id == restaurantDetail.id);

                                return GestureDetector(
                                  onTap: () {
                                    if (isFavorite) {
                                      controller.removeFromFavorite(
                                          restaurantDetail.id);
                                    } else {
                                      controller.addToFavorite(
                                        FavoriteRestaurant(
                                          id: restaurantDetail.id,
                                          name: restaurantDetail.name,
                                          description:
                                              restaurantDetail.description,
                                          pictureId: restaurantDetail.pictureId,
                                          city: restaurantDetail.city,
                                          rating: restaurantDetail.rating,
                                        ),
                                      );
                                    }
                                  },
                                  child: Icon(
                                    isFavorite
                                        ? Icons.bookmark
                                        : Icons.bookmark_outline,
                                    color: Colors.amber,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      titlePadding: const EdgeInsets.only(left: 40, bottom: 12),
                      background: Hero(
                        tag: "restaurant_image_${restaurantDetail.pictureId}",
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: imageURL,
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                          placeholder: (context, url) => const FadeInImage(
                            fit: BoxFit.cover,
                            fadeOutDuration: Duration(milliseconds: 1500),
                            image: AssetImage(
                                'assets/images/lovely food placeholder.jpg'),
                            placeholder: AssetImage(
                                'assets/images/lovely food placeholder.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.storefront,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    restaurantDetail.name.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: RestaurantRating(
                                  rating: restaurantDetail.rating),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  restaurantDetail.city.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: 8.0, // Jarak antar chip atau button
                              runSpacing: 8.0, // Jarak antar baris
                              children: [
                                RestaurantCategory(
                                    categories: restaurantDetail.categories),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(restaurantDetail.description,
                              textAlign: TextAlign.justify,
                              maxLines: 6,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 56, 54, 54))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Costumer Review'.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: RestaurantReview(
                          customerReviews: restaurantDetail.customerReviews,
                          restaurantId: restaurantDetail.id,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.article_outlined,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Menu'.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: RestaurantMenu(menus: restaurantDetail.menus),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
