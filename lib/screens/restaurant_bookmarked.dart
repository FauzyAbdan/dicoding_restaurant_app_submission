import 'package:dicoding_restaurant_app_submission/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class RestaurantBookmarked extends StatelessWidget {
  const RestaurantBookmarked({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_outlined,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              'Your bookmarked restaurants will be displayed here.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
