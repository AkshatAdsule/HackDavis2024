class Item {
  int id;
  String name;
  int score;
  String? image;
  String ownerId;
  DateTime createdAt;
  DateTime updatedAt;
  int? freedgeId;

  Map<String, dynamic>? owner;

  Item({
    required this.id,
    required this.name,
    required this.score,
    required this.image,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.freedgeId,
    this.owner,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      score: json['score'],
      image: json['image'],
      ownerId: json['ownerId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      freedgeId: json['freedgeId'],
      owner: json['owner'],
    );
  }
}
