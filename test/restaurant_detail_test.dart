import 'dart:convert'; // Import library untuk JSON encoding/decoding
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:dicoding_restaurant_app_submission/data/restaurant_detail_model.dart'; // Import model restaurant detail
import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';

void main() {
  group('Restaurant API Service Test', () {
    test('Parsing JSON data for restaurant detail', () async {
      // Arrange
      const String restaurantId =
          'rqdv5juczeskfw1e867'; // ID restoran yang ingin diambil detailnya
      final mockClient = MockClient((request) async {
        // Mengembalikan respons palsu sesuai dengan request yang dilakukan
        if (request.url.toString() ==
            'https://restaurant-api.dicoding.dev/detail/$restaurantId') {
          // Buat respons JSON sesuai dengan data yang diberikan
          final Map<String, dynamic> jsonResponse = {
            "error": false,
            "message": "success",
            "restaurant": {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description": "Lorem ipsum dolor sit amet...",
              "pictureId": "14",
              "city": "Medan",
              "rating": 4.2
              // Tambahkan properti restoran detail lainnya sesuai kebutuhan
            }
          };
          return http.Response(jsonEncode(jsonResponse), 200);
        } else {
          return http.Response('Not Found', 404);
        }
      });

      final restaurantApiService = RestaurantApiService(client: mockClient);

      // Act
      final RestaurantDetail restaurantDetail =
          await restaurantApiService.fetchRestaurantDetails(restaurantId);

      // Assert
      // Lakukan asertasi terhadap data detail restoran yang dihasilkan
      expect(
          restaurantDetail.id, restaurantId); // Memastikan ID restoran sesuai
      expect(restaurantDetail.name, 'Melting Pot'); // Memeriksa nama restoran
      // Periksa properti detail restoran lainnya
      // Anda dapat menambahkan lebih banyak asertasi sesuai dengan kebutuhan
    });
  });
}
