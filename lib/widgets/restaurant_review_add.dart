// restaurant_review_add.dart
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';
import 'package:flutter/material.dart';

Completer<void> _flushbarCompleter = Completer<void>();
Future<void> addReview(BuildContext context, String restaurantId) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(
            child: Text(
          'Tambahkan Review',
          style: TextStyle(color: Colors.blueGrey),
        )),
        backgroundColor: Colors.blueGrey.shade100,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                ),
                style: const TextStyle(color: Colors.blueGrey),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Tulis review',
                ),
                style: const TextStyle(color: Colors.blueGrey),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop({
                'name': nameController.text,
                'content': contentController.text,
              });
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  ).then(
    (result) async {
      if (result != null) {
        String name = result['name'];
        String content = result['content'];

        if (name.isNotEmpty && content.isNotEmpty) {
          try {
            bool success = await RestaurantApiService().postReviewRestaurants(
              restaurantId,
              name,
              content,
            );

            if (success) {
              _showFlushbar(
                  context, 'Terima kasih! Review berhasil dikirim.', true);
            } else {
              // Handle the case where review posting failed
              _showFlushbar(context, 'Error posting review', false);
            }
          } catch (error) {
            // Handle other errors that may occur during the process

            _showFlushbar(
                context, 'Error: Tidak dapat mengirimkan review', false);
          }
        } else {
          // Handle the case where name or content is empty
          _showFlushbar(context, 'Nama dan Isi Review harus diisi', false);
        }
      }
    },
  );
  await _flushbarCompleter.future;
}

void _showFlushbar(BuildContext context, String message, bool isSuccess) {
  Flushbar(
    message: message,
    duration: const Duration(seconds: 4),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    onStatusChanged: (status) {
      if (status == FlushbarStatus.DISMISSED) {
        _flushbarCompleter
            .complete(); // Complete the Completer when Flushbar is dismissed
      }
    },
  ).show(context);
}
