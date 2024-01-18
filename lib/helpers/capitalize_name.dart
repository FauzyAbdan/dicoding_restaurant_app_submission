String capitalize(String text) {
  if (text.isEmpty) {
    return text;
  }

  return text
      .split(' ')
      .map((word) => word.isEmpty
          ? ''
          : word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join(' ');
}
