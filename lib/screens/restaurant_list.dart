//restaurant_list.dart

import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_list_model.dart';
import 'package:dicoding_restaurant_app_submission/helpers/random_restaurant_of_the_month.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_search.dart';
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
  final _apiService = RestaurantApiService();
  late Future<List<Restaurant>> _restaurants;

  @override
  void initState() {
    super.initState();
    _restaurants = _apiService.fetchRestaurants();
  }

  Future<void> _refreshData() async {
    setState(() {
      _restaurants = RestaurantApiService().fetchRestaurants();
    });
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
                    Get.to(() => const RestaurantSearch());
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
                    image: AssetImage(getRandomImage()), fit: BoxFit.cover),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: FutureBuilder<List<Restaurant>>(
            future: _restaurants,
            initialData: null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: ListView.separated(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return shimmerLoadingRestaurantList();
                    },
                    separatorBuilder: (_, __) => const SizedBox(),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final restaurant = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('detail', arguments: restaurant.id);
                        },
                        child: buildRestaurantList(context, restaurant),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: ErrorLoadingRestaurant()),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: ListView.separated(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return shimmerLoadingRestaurantList();
                    },
                    separatorBuilder: (_, __) => const SizedBox(),
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
