import 'package:dicoding_restaurant_app_submission/screens/restaurant_favorite.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_list.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_search.dart';
import 'package:dicoding_restaurant_app_submission/screens/restaurant_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        switch (index) {
          case 0:
            Get.offAll(() => const RestaurantList());
            break;
          case 1:
            Get.offAll(() => RestaurantSearch());
            break;
          case 2:
            Get.offAll(() => const RestaurantFavorite());
            break;
          case 3:
            Get.offAll(() => const RestaurantSetting(
                  restaurants: [],
                ));
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
    );
  }
}
