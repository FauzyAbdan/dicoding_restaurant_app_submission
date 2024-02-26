import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_rating.dart';

void main() {
  testWidgets('RestaurantRating menampilkan rating yang benar',
      (WidgetTester tester) async {
    // Buat widget RestaurantRating dengan rating tertentu
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RestaurantRating(rating: 4.0),
        ),
      ),
    );

    // Verifikasi apakah jumlah bintang yang benar ditampilkan berdasarkan rating
    expect(find.byIcon(Icons.star),
        findsNWidgets(4)); // Mengharapkan 4 bintang penuh
    expect(find.byIcon(Icons.star_border),
        findsOneWidget); // Mengharapkan 1 bintang kosong
    expect(find.text('4.0'),
        findsOneWidget); // Verifikasi apakah teks rating ditampilkan
  });
}
