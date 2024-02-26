import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:dicoding_restaurant_app_submission/data/restaurant_list_model.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';

void main() {
  group('Search Restaurants Test', () {
    test('Search restaurants by query', () async {
      // Arrange
      const String query = 'salmon'; // Query pencarian restoran
      final mockClient = MockClient((request) async {
        // Mengembalikan respons palsu sesuai dengan request yang dilakukan
        if (request.url.toString() ==
            'https://restaurant-api.dicoding.dev/search?q=$query') {
          // Buat respons JSON sesuai dengan data yang diberikan
          final Map<String, dynamic> jsonResponse = {
            "error": false,
            "message": "success",
            "restaurants": [
              {
                "id": "rqdv5juczeskfw1e867",
                "name": "Melting Pot",
                "description": "Best place to have pizza.",
                "pictureId": "14",
                "city": "Medan",
                "rating": 4.2
              },
            ]
          };

          return http.Response(jsonEncode(jsonResponse), 200);
        } else {
          return http.Response('Not Found', 404);
        }
      });

      final restaurantApiService = RestaurantApiService(client: mockClient);

      // Act
      final List<Restaurant> restaurants =
          await restaurantApiService.searchRestaurants(query);

      // Assert
      // Lakukan asertasi terhadap data restoran yang dihasilkan
      expect(restaurants.length,
          12); // Memastikan jumlah restoran yang memiliki kata kunci sesuai dengan respons
      expect(restaurants[0].name, 'Melting Pot');
    });
  });
}
