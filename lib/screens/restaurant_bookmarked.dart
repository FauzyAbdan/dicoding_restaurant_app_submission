import 'package:dicoding_restaurant_app_submission/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class RestaurantBookmarked extends StatelessWidget {
  const RestaurantBookmarked({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_outlined,
              size: 40,
            ),
            Text(
              'Restaurant favoritmu akan tampil disini saat kamu menyimpannya.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
