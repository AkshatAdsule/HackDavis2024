class FoodData {
  String name;
  String? image;
  double score;
  int quantity;
  String? ownerId;

  FoodData({
    required this.name,
    this.image,
    required this.score,
    required this.quantity,
    this.ownerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'score': score,
      'quantity': quantity,
      'ownerId': ownerId,
    };
  }
}
