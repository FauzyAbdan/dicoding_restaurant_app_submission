import 'dart:math';

String getRandomFoodImage() {
  final random = Random();
  final foodImages = [
    'assets/images/foods/steak 1.jpg',
    'assets/images/foods/sweets.jpg',
    'assets/images/foods/toastie salmon.jpg',
    'assets/images/foods/tuna-tartare.jpg',
    'assets/images/foods/white chocolate.png',
    'assets/images/foods/yummy 2.jpg',
    'assets/images/foods/yummy cream cheese.jpg',
    'assets/images/foods/yummy.jpg',
    'assets/images/foods/foods.jpg',
    'assets/images/foods/foods 2.jpg',
    'assets/images/foods/foods 3.jpg',
    'assets/images/foods/foods 4.jpg',
    'assets/images/foods/foods 5.jpg',
    'assets/images/foods/foods 6.jpg',
    'assets/images/foods/foods 7.jpg',
    'assets/images/foods/foods 8.jpg',
    'assets/images/foods/foods 9.jpg',
  ];
  final index = random.nextInt(foodImages.length);
  return foodImages[index];
}

String getRandomDrinkImage() {
  final random = Random();
  final drinkImages = [
    'assets/images/drinks/drink 1.jpg',
    'assets/images/drinks/drink 2.jpg',
    'assets/images/drinks/drink 3.jpg',
    'assets/images/drinks/drink 4.jpg',
    'assets/images/drinks/drink 5.jpg',
    'assets/images/drinks/drink 6.jpg',
    'assets/images/drinks/coffee 1.jpg',
    'assets/images/drinks/coffee 2.jpg',
    'assets/images/drinks/coffee 3.jpg',
    'assets/images/drinks/coffee 4.jpg',
    'assets/images/drinks/coffee 5.jpg',
    'assets/images/drinks/coffee 6.jpg',
    'assets/images/drinks/coffee 7.jpg',
  ];
  final index = random.nextInt(drinkImages.length);
  return drinkImages[index];
}
