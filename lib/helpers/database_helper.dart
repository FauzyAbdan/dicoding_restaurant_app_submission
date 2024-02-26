//database_helper.dart

import 'package:dicoding_restaurant_app_submission/data/restaurant_favorite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteDatabaseHelper {
  static const String _tableName = 'favorite_restaurants';
  static late Database _database;

  static Future<void> initializeDatabase() async {
    try {
      String path = await getDatabasesPath();
      _database = await openDatabase(
        join(path, 'favorite_restaurants.db'),
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            '''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL
          )
          ''',
          );
        },
      );
    } catch (ex) {
      // ignore: avoid_print
      print('Error initializing database: $ex');
    }
  }

  static Future<List<Map<String, dynamic>>> getAllFavoriteRestaurants() async {
    await initializeDatabase();
    return _database.query(_tableName);
  }

  Future<bool> isRestaurantFavorite(String id) async {
    await initializeDatabase();
    final List<Map<String, dynamic>> maps = await _database.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }

  Future<void> insertFavoriteRestaurant(FavoriteRestaurant restaurant) async {
    await initializeDatabase();
    await _database.insert(
      _tableName,
      restaurant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavoriteRestaurant(String id) async {
    await initializeDatabase();
    await _database.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
