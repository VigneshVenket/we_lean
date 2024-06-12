

class Location {
  int id;
  String name;

  Location({required this.id, required this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
