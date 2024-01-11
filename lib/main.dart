import 'package:flutter/material.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_model.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_list.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dicoding Restaurant App Submission 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: RestaurantList(),
      routes: {
        // '/': (context) => RestaurantList(),
        '/detail': (context) => DetailRestaurant(
              restaurant:
                  ModalRoute.of(context)!.settings.arguments as Restaurant,
            )
      },
    );
  }
}
