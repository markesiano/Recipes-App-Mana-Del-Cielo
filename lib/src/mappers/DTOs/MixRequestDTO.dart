import 'package:recipes_app_mana_del_cielo/src/mappers/DTOs/IngredientRequestDTO.dart';
import 'package:recipes_app_mana_del_cielo/src/mappers/DTOs/MixerRequestDTO.dart';

class MixRequestDTO {
  String title;
  String description;
  List<IngredientRequestDTO> ingredients;
  MixerRequestDTO mixer;
  int minutes;
  String notes;

  MixRequestDTO({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.mixer,
    required this.minutes,
    required this.notes,
  });
}
