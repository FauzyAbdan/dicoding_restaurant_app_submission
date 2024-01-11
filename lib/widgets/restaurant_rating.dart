// restaurant_rating.dart
import 'package:flutter/material.dart';

class RestaurantRating extends StatelessWidget {
  final double rating;

  const RestaurantRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Gabungan list icon bintang dan angka rating
        ...List.generate(
          5,
          (index) => Icon(
            index < rating.round() ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: const TextStyle(color: Colors.blueGrey),
        ),
      ],
    );
  }
}
