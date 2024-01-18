//restaurant_detail.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_detail_model.dart';
import 'package:dicoding_restaurant_app_submission/widgets/error_loading_restaurant.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_category.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_menu.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_rating.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_review.dart';
import 'package:flutter/material.dart';

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
  final RestaurantApiService _apiService = RestaurantApiService();
  late Future<RestaurantDetail> _restaurantDetail;
  late String imageURL;

  @override
  void initState() {
    super.initState();
    _restaurantDetail = _apiService.fetchRestaurantDetails(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<RestaurantDetail>(
        future: _restaurantDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const ErrorLoadingRestaurant();
          } else if (!snapshot.hasData) {
            return const Text('No data available');
          } else {
            final restaurantDetail = snapshot.data!;
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
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.bookmark_outline,
                              color: Colors.amber,
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
