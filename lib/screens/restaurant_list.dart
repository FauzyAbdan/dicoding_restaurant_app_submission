//restaurant_list.dart

import 'package:dicoding_restaurant_app_submission/controllers/restaurant_list_controller.dart';
import 'package:dicoding_restaurant_app_submission/helpers/random_restaurant_of_the_month.dart';

import 'package:dicoding_restaurant_app_submission/widgets/bottom_navigation_bar.dart';
import 'package:dicoding_restaurant_app_submission/widgets/error_loading_restaurant.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_list_tile.dart';
import 'package:dicoding_restaurant_app_submission/widgets/shimmer_loading_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  RestaurantListState createState() => RestaurantListState();
}

class RestaurantListState extends State<RestaurantList> {
  final RestaurantListController _restaurantListController =
      Get.put(RestaurantListController());

  Future<void> _refreshData() async {
    await _restaurantListController.fetchRestaurants();
  }

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
              expandedHeight: 240,
              actions: <Widget>[
                IconButton(
                  padding: const EdgeInsets.only(top: 10, right: 20),
                  icon: const Icon(Icons.search),
                  tooltip: 'Cari restoran',
                  onPressed: () {
                    Get.toNamed('/search');
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  "BEST RESTAURANT OF THE MONTH",
                  style: TextStyle(fontSize: 16),
                ),
                titlePadding: const EdgeInsets.only(left: 30, bottom: 16),
                background: Image(
                  image: AssetImage(getRandomImage()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Obx(
            () {
              if (_restaurantListController.hasError) {
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
              } else if (_restaurantListController.restaurants.isEmpty) {
                return Center(
                  child: ListView.separated(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return shimmerLoadingRestaurantList();
                    },
                    separatorBuilder: (_, __) => const SizedBox(),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _restaurantListController.restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant =
                          _restaurantListController.restaurants[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('detail', arguments: restaurant.id);
                        },
                        child: buildRestaurantList(context, restaurant),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
