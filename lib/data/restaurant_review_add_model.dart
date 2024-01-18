// restaurant_review_add_model.dart
class ReviewAddModel {
  final String id;
  final String name;
  final String review;

  ReviewAddModel({
    required this.id,
    required this.name,
    required this.review,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'review': review,
    };
  }
}
