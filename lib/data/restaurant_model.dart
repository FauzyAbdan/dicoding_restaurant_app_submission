//restaurant_model.dart

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;
  // Constructor
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  // Factory constructor for parsing JSON data
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'].toDouble(),
      menus: Menus.fromJson(json['menus']),
    );
  }

  // Method to convert a list of Restaurants from JSON
  static List<Restaurant> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Restaurant.fromJson(json)).toList();
  }
}

class Menus {
  List<Food> foods;
  List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  // Factory constructor for parsing JSON data
  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: List<Food>.from(json['foods'].map((x) => Food.fromJson(x))),
      drinks: List<Drink>.from(json['drinks'].map((x) => Drink.fromJson(x))),
    );
  }
}

class Food {
  String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(name: json['name']);
  }
}

class Drink {
  String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(name: json['name']);
  }
}
