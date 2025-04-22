// Class of mixer
import 'package:recipes_app_mana_del_cielo/src/mappers/DTOs/ToolRequestDTO.dart';

class MixerRequestDTO {
  int id;
  String name;
  String description;
  ToolRequestDTO tool;

  MixerRequestDTO(
      {required this.id,
      required this.name,
      required this.description,
      required this.tool});
}
