import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_model.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_list_tile.dart';
import 'package:dicoding_restaurant_app_submission/helpers/random_restaurant_of_the_month.dart';

class RestaurantList extends StatelessWidget {
  final Future<List<Restaurant>> _restaurants = fetchRestaurants();

  RestaurantList({super.key});

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
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cari restoran')));
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
              )),
        ];
      },
      body: FutureBuilder<List<Restaurant>>(
        future: _restaurants,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/detail',
                            arguments: snapshot.data![index]);
                      },
                      child:
                          buildRestaurantList(context, snapshot.data![index]));
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error loading restaurants: ${snapshot.error}");
          } else {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                      height:
                          10), // Tambahkan jarak antara indicator dan tulisan
                  Text("Mohon tunggu! Data sedang dimuat"),
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}

Future<List<Restaurant>> fetchRestaurants() async {
  await Future.delayed(const Duration(seconds: 3));
  String jsonString =
      await rootBundle.loadString('assets/local_restaurant.json');
  final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
  final restaurantsList = jsonData['restaurants'] as List;
  return Restaurant.fromJsonList(restaurantsList);
}
