import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLoadingRestaurantList() {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
      height: 140,
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.amber.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              width: 150,
              height: 130,
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        width: 180,
                        height: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        height: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        height: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        height: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        width: 140,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
