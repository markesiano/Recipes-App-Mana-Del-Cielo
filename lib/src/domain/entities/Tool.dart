// Class of tools of mixer
class Tool {
  int id;
  String name;
  String description;

  Tool({required this.id, required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}
