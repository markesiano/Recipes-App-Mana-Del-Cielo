class ToolRequestDTO {
  int id;
  String name;
  String description;

  ToolRequestDTO(
      {required this.id, required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}
