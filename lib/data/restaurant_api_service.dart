//restaurant_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dicoding_restaurant_app_submission/data/restaurant_detail_model.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_list_model.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_review_add_model.dart';

class RestaurantApiService {
  final String baseUrl = 'https://restaurant-api.dicoding.dev';
  final http.Client client;

  RestaurantApiService({http.Client? client})
      : client = client ?? http.Client();

  Future<List<Restaurant>> fetchRestaurants() async {
    await Future.delayed(const Duration(seconds: 3));

    final response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> restaurantList = data['restaurants'];
      return restaurantList.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetail> fetchRestaurantDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final restaurantDetail = RestaurantDetail.fromJson(data['restaurant']);
      return restaurantDetail;
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final restaurants = (data['restaurants'] as List)
          .map((restaurant) => Restaurant.fromJson(restaurant))
          .toList();
      return restaurants;
    } else {
      throw Exception('Failed to fetch search results');
    }
  }

  Future<bool> postReviewRestaurants(
      String id, String name, String review) async {
    final reviewModel = ReviewAddModel(id: id, name: name, review: review);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/review'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reviewModel.toJson()),
      );

      final responseData = json.decode(response.body);

      if (responseData['error'] != null && responseData['message'] != null) {
        if (!responseData['error'] && responseData['message'] == 'success') {
          return true; // Review successfully posted
        } else {
          // Handle the case where posting the review failed
          throw Exception(responseData['message'] ?? 'Failed to post review');
        }
      } else {
        // Handle the case where the response format is invalid
        throw Exception('Invalid response format');
      }
    } catch (error) {
      // Handle other errors that may occur during the review posting process
      throw Exception('An error occurred while posting review: $error');
    }
  }
}
