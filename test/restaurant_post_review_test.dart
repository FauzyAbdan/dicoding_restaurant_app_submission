import 'dart:convert'; // Import library untuk JSON encoding/decoding
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';

void main() {
  group('Post Review Restaurants Test', () {
    test('Post review for a restaurant', () async {
      // Arrange
      const String restaurantId =
          'rqdv5juczeskfw1e867'; // ID restoran yang ingin direview
      const String name = 'John Doe'; // Nama penulis review
      const String review = 'Great food and service!'; // Review restoran
      final mockClient = MockClient((request) async {
        // Mengembalikan respons palsu sesuai dengan request yang dilakukan
        if (request.url.toString() ==
            'https://restaurant-api.dicoding.dev/review') {
          // Buat respons JSON sesuai dengan data yang diberikan
          final Map<String, dynamic> jsonResponse = {
            "error": false,
            "message": "success",
            // Tambahkan properti lainnya sesuai kebutuhan
          };
          return http.Response(jsonEncode(jsonResponse), 200);
        } else {
          return http.Response('Not Found', 404);
        }
      });

      final restaurantApiService = RestaurantApiService(client: mockClient);

      // Act
      final bool isReviewPosted =
          await restaurantApiService.postReviewRestaurants(
        restaurantId,
        name,
        review,
      );

      // Assert
      expect(isReviewPosted, true); // Memastikan review berhasil diposting
    });
  });
}
