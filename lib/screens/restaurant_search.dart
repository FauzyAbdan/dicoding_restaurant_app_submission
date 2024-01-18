// restaurant_search.dart
import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_list_model.dart';
import 'package:dicoding_restaurant_app_submission/widgets/bottom_navigation_bar.dart';
import 'package:dicoding_restaurant_app_submission/widgets/error_loading_restaurant.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_list_tile.dart';
import 'package:dicoding_restaurant_app_submission/widgets/shimmer_loading_list_tile.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RestaurantSearch extends StatefulWidget {
  const RestaurantSearch({super.key});

  @override
  RestaurantSearchState createState() => RestaurantSearchState();
}

class RestaurantSearchState extends State<RestaurantSearch> {
  final _apiService = RestaurantApiService();
  late Future<List<Restaurant>> _searchResults;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchResults = Future.value([]);
  }

  void _performSearch(String query) {
    setState(() {
      _searchResults = _apiService.searchRestaurants(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Cari restauran, makanan & minuman disini...',
          ),
          onSubmitted: (query) {
            _performSearch(query);
          },
          autofocus: true,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final query = _searchController.text;
              if (query.isNotEmpty) {
                _performSearch(query);
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (_searchController.text.isEmpty) {
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: ListView.separated(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return shimmerLoadingRestaurantList();
                },
                separatorBuilder: (_, __) => const SizedBox(),
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
          } else if (snapshot.hasData && snapshot.data != null) {
            final searchResults = snapshot.data!;
            if (searchResults.isEmpty) {
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
                      _searchController.text,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final restaurant = searchResults[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('detail', arguments: restaurant.id);
                        },
                        child: buildRestaurantList(context, restaurant),
                      ),
                    ],
                  );
                },
              );
            }
          } else {
            return const Center(child: Text('Masukkan kata kunci disini'));
          }
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
