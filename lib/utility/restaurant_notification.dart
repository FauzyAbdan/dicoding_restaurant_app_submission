//restaurant_notification.dart
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_api_service.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_list_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Define the plugin instance
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Function to show random restaurant notification
Future<void> showRandomRestaurantNotification(List<Restaurant> restaurants,
    {DateTime? scheduledTime}) async {
  // Initialize the timezone
  tz.initializeTimeZones();

  if (restaurants.isEmpty) {
    // ignore: avoid_print
    print('Daftar restoran kosong');
    return;
  }
// ignore: avoid_print
  print('Jumlah restoran: ${restaurants.length}');

  // Generate random index to select a random restaurant
  Random random = Random();
  int randomIndex = random.nextInt(restaurants.length);

  // Get the randomly selected restaurant
  Restaurant randomRestaurant = restaurants[randomIndex];

  // Fetch the image bytes for the restaurant
  final Uint8List imageBytes =
      await _fetchRestaurantImageBytes(randomRestaurant.pictureId);

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'restaurant_notification_channel',
    'Restaurant Notifications',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    styleInformation: BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(base64Encode(imageBytes)),
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      contentTitle: randomRestaurant.name,
      htmlFormatContentTitle: true,
      summaryText: randomRestaurant.description,
      htmlFormatSummaryText: true,
    ),
  );

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: null,
  );

  if (scheduledTime != null) {
    tz.TZDateTime scheduledDateTime =
        tz.TZDateTime.from(scheduledTime, tz.local);

    // Schedule notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      randomRestaurant.name,
      randomRestaurant.description,
      scheduledDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  } else {
    await flutterLocalNotificationsPlugin.show(
      0,
      randomRestaurant.name,
      randomRestaurant.description,
      platformChannelSpecifics,
    );
  }
}

// Function to fetch the image bytes from the API
Future<Uint8List> _fetchRestaurantImageBytes(String pictureId) async {
  final restaurantApiService = RestaurantApiService();
  final imageUrl =
      '${restaurantApiService.baseUrl}/images/medium/$pictureId'; // Construct image URL
  final response = await restaurantApiService.client.get(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    throw Exception('Failed to download image');
  }
}

// Fungsi untuk menjadwalkan notifikasi setiap jam 11:00 siang
void scheduleDailyNotification(List<Restaurant> restaurants) async {
  // Dapatkan waktu saat ini
  DateTime now = DateTime.now();
  // Dapatkan tanggal hari ini dengan jam 11:00 siang
  DateTime scheduledTime = DateTime(now.year, now.month, now.day, 11, 0);

  // Panggil fungsi untuk menampilkan notifikasi
  await showRandomRestaurantNotification(restaurants,
      scheduledTime: scheduledTime);
}
