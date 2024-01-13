import 'package:flutter/material.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_model.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_menu.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_rating.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const DetailRestaurant({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
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
                        restaurant.name.toUpperCase(),
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
                    tag: "restaurant_image_${restaurant.pictureId}",
                    child: Image(
                        image: NetworkImage(restaurant.pictureId),
                        fit: BoxFit.cover),
                  ),
                )),
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6, bottom: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.storefront,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                restaurant.name.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      RestaurantRating(rating: restaurant.rating)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(restaurant.city),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(restaurant.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 54, 68, 75))),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Menu".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: RestaurantMenu(menus: restaurant.menus),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
