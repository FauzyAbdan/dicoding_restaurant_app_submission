import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_model.dart';

Future<List<Restaurant>> fetchRestaurants() async {
  await Future.delayed(const Duration(seconds: 3));
  String jsonString =
      await rootBundle.loadString('assets/local_restaurant.json');
  final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
  final restaurantsList = jsonData['restaurants'] as List;
  return Restaurant.fromJsonList(restaurantsList);
}
