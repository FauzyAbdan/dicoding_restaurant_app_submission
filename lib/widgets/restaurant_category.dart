// restaurant_category.dart
import 'package:dicoding_restaurant_app_submission/data/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class RestaurantCategory extends StatelessWidget {
  final List<Category> categories;

  const RestaurantCategory({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: categories.map((category) {
        return Chip(
          label: Text(
            category.name,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          shape: const StadiumBorder(
            side: BorderSide(color: Colors.white),
          ),
          visualDensity: const VisualDensity(horizontal: -3.0, vertical: -3.0),
        );
      }).toList(),
    );
  }
}
