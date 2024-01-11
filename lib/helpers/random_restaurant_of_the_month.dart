import 'dart:math';

String getRandomImage() {
  const imagePaths = [
    "assets/images/lovely food placeholder.jpg",
    "assets/images/sliver homepage 2.jpg",
    "assets/images/sliver homepage.jpg",
  ];

  final randomIndex = Random().nextInt(imagePaths.length);
  return imagePaths[randomIndex];
}
