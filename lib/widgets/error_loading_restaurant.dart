// error_loading_restaurant_list.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorLoadingRestaurant extends StatelessWidget {
  const ErrorLoadingRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              "Mohon maaf karena saat ini tidak bisa menampilkan restaurant kesayangan Anda.",
              style: TextStyle(fontSize: 16),
            ),
          ),
          // Add the button
          ElevatedButton(
            onPressed: () => Get.offNamed('/'),
            child: const Text('Muat Ulang'),
          ),
        ],
      ),
    );
  }
}
