//restaurant_review.dart

import 'package:dicoding_restaurant_app_submission/data/restaurant_detail_model.dart';
import 'package:dicoding_restaurant_app_submission/helpers/capitalize_name.dart';
import 'package:dicoding_restaurant_app_submission/widgets/restaurant_review_add.dart';
import 'package:flutter/material.dart';

class RestaurantReview extends StatefulWidget {
  final List<CustomerReview> customerReviews;
  final String restaurantId;

  const RestaurantReview({
    Key? key,
    required this.customerReviews,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<RestaurantReview> createState() => _RestaurantReviewState();
}

class _RestaurantReviewState extends State<RestaurantReview> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemCount: (widget.customerReviews.isEmpty)
            ? 1
            : widget.customerReviews.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.customerReviews.length &&
              widget.customerReviews.isNotEmpty) {
            // Container untuk menambahkan atau memposting review
            return GestureDetector(
              onTap: () {
                addReview(context, widget.restaurantId);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  height: 150,
                  width: 210,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.create_rounded,
                        size: 40,
                        color: Colors.grey,
                      ),
                      Text(
                        "Tulis Review",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            final review = widget.customerReviews[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              // Item review
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 150,
                width: 210,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blueGrey,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              capitalize(review.name),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          review.review,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              review.date,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
