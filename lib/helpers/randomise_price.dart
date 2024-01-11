import 'dart:math';

extension RandomExtensions on Random {
  int between(int min, int max) {
    return min + nextInt(max - min + 1);
  }
}
