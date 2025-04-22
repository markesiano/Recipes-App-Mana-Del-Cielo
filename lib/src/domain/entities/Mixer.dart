// Class of mixer
import 'Tool.dart';

class Mixer {
  int id;
  String name;
  String description;
  Tool tool;

  Mixer(
      {required this.id,
      required this.name,
      required this.description,
      required this.tool});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'tool': tool.toMap(),
    };
  }
}
