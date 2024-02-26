//restaurant_list_test.dart
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:dicoding_restaurant_app_submission/data/restaurant_list_model.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';

void main() {
  group('Restaurant API Service Test', () {
    test('Parsing JSON data for restaurant list', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        // Mengembalikan respons palsu sesuai dengan request yang dilakukan
        if (request.url.toString() ==
            'https://restaurant-api.dicoding.dev/list') {
          // Buat respons JSON sesuai dengan data yang diberikan
          final Map<String, dynamic> jsonResponse = {
            "error": false,
            "message": "success",
            "count": 20,
            "restaurants": [
              {
                "id": "rqdv5juczeskfw1e867",
                "name": "Melting Pot",
                "description": "Lorem ipsum dolor sit amet...",
                "pictureId": "14",
                "city": "Medan",
                "rating": 4.2
              },
              // Data restoran lainnya
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
          await restaurantApiService.fetchRestaurants();

      // Assert
      // Lakukan asertasi terhadap data restoran yang dihasilkan
      expect(restaurants.length,
          20); // Memastikan jumlah restoran sesuai dengan respons
      expect(restaurants[0].name,
          'Melting Pot'); // Memeriksa nama restoran pertama
    });
  });
}
