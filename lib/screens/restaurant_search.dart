// restaurant_search.dart
import 'package:dicoding_restaurant_app_submission/controllers/restaurant_search_controller.dart';
import 'package:dicoding_restaurant_app_submission/widgets/bottom_navigation_bar.dart';
import 'package:dicoding_restaurant_app_submission/widgets/error_loading_restaurant.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_list_tile.dart';
import 'package:dicoding_restaurant_app_submission/widgets/shimmer_loading_list_tile.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RestaurantSearch extends StatelessWidget {
  final RestaurantSearchController _searchController =
      Get.put(RestaurantSearchController());

  RestaurantSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: TextEditingController(
              text: _searchController.searchController.value),
          decoration: const InputDecoration(
            hintText: 'Cari restauran, makanan & minuman disini...',
          ),
          onSubmitted: (query) {
            _searchController.searchController.value = query;
          },
          autofocus: true,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final query = _searchController.searchController.value;
              if (query.isNotEmpty) {
                _searchController.searchRestaurants(query);
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (_searchController.searchController.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_rounded,
                  size: 40,
                ),
                Text(
                  'Yuk cari restoran atau menu favorit!',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        } else if (_searchController.isLoading.value) {
          return Center(
            child: ListView.separated(
              itemCount: 6,
              itemBuilder: (context, index) {
                return shimmerLoadingRestaurantList();
              },
              separatorBuilder: (_, __) => const SizedBox(),
            ),
          );
        } else if (_searchController.hasError.value) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: ErrorLoadingRestaurant()),
              ],
            ),
          );
        } else if (_searchController.searchResults.isNotEmpty) {
          return ListView.builder(
            itemCount: _searchController.searchResults.length,
            itemBuilder: (context, index) {
              final restaurant = _searchController.searchResults[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed('detail', arguments: restaurant.id);
                },
                child: buildRestaurantList(context, restaurant),
              );
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 40,
                ),
                const Text(
                  'Tidak ada hasil pencarian untuk kata kunci',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  _searchController.searchController.value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
