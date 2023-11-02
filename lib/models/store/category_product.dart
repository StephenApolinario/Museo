class SouvenirsCategory {
  final String name;

  SouvenirsCategory({
    required this.name,
  });

  factory SouvenirsCategory.fromJson(Map<String, dynamic> json) {
    return SouvenirsCategory(
      name: json['name'],
    );
  }
}
