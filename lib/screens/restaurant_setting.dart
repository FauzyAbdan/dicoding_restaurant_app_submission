//restaurant_setting.dart

import 'package:flutter/material.dart';
import 'package:dicoding_restaurant_app_submission/data/restaurant_list_model.dart';
import 'package:dicoding_restaurant_app_submission/utility/restaurant_notification.dart';
import 'package:dicoding_restaurant_app_submission/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantSetting extends StatefulWidget {
  final List<Restaurant> restaurants;
  const RestaurantSetting({Key? key, required this.restaurants})
      : super(key: key);

  @override
  RestaurantSettingState createState() => RestaurantSettingState();
}

class RestaurantSettingState extends State<RestaurantSetting> {
  bool _isNotificationOn = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _saveSettings();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Notifikasi Rekomendasi Restauran',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Switch(
                  value: _isNotificationOn,
                  onChanged: (value) {
                    setState(() {
                      _isNotificationOn = value;
                      _saveSettings();
                      if (_isNotificationOn) {
                        scheduleDailyNotification(widget.restaurants);
                      }
                    });
                  },
                ),
              ],
            ),
            if (_isNotificationOn)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Anda akan mendapatkan notifikasi yang merekomendasikan restauran setiap jam 11:00 siang.',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notification_status', _isNotificationOn);
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNotificationOn = prefs.getBool('notification_status') ?? false;
      if (_isNotificationOn && widget.restaurants.isNotEmpty) {
        // Panggil fungsi scheduleDailyNotification jika notifikasi diaktifkan sebelumnya
        scheduleDailyNotification(widget.restaurants);
      }
    });
  }
}
