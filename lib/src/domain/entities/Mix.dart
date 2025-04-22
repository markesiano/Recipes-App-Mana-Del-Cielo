import 'package:recipes_app_mana_del_cielo/src/domain/entities/Ingredient.dart';

import 'Mixer.dart';

class Mix {
  int id;
  String title;
  String description;
  List<Ingredient> ingredients;
  Mixer mixer;
  int minutes;
  String notes;
  Mix(
      {required this.id,
      required this.title,
      required this.description,
      required this.ingredients,
      required this.mixer,
      required this.minutes,
      required this.notes});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients.map((e) => e.toMap()).toList(),
      'mixer': mixer.toMap(),
      'minutes': minutes,
      'notes': notes,
    };
  }
}
