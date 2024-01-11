import 'package:flutter/material.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_model.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_rating.dart';

Widget buildRestaurantList(BuildContext context, Restaurant restaurants) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(restaurants.pictureId),
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8))),
            width: 150,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        restaurants.name.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      textAlign: TextAlign.justify,
                      restaurants.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: RestaurantRating(rating: restaurants.rating)),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
