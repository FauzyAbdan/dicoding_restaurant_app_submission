import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_model.dart';
import 'package:dicoding_restaurant_app_submission/helpers/randomise_price.dart';
import 'package:dicoding_restaurant_app_submission/helpers/random_menu_images.dart';

class RestaurantMenu extends StatelessWidget {
  final Menus menus;

  const RestaurantMenu({Key? key, required this.menus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Makanan", style: TextStyle(fontSize: 20)),
        GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
            itemCount: menus.drinks.length,
            itemBuilder: (context, index) {
              final imagePath = getRandomFoodImage();

              return Padding(
                padding: const EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(imagePath).image,
                              ),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                          width: double.maxFinite,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10.0, right: 1),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    menus.drinks[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Rp. ${NumberFormat.decimalPattern().format(Random().between(25000, 200000)).replaceAll(',', '.')}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                      fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        const SizedBox(height: 10),
        const Text("Minuman", style: TextStyle(fontSize: 20)),
        GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
            itemCount: menus.drinks.length,
            itemBuilder: (context, index) {
              final imagePath = getRandomDrinkImage();

              return Padding(
                padding: const EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(imagePath).image,
                              ),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                          width: double.maxFinite,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10.0, right: 1),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    menus.drinks[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Rp. ${NumberFormat.decimalPattern().format(Random().between(20000, 100000)).replaceAll(',', '.')}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                      fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}
