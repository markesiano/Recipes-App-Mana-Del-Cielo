import 'package:recipes_app_mana_del_cielo/src/domain/entities/Mixer.dart';

class MixModel {
  final int id;
  String title;
  String description;
  List ingredients;
  Mixer mixer;
  int minutes;
  String notes;
  bool status;

  MixModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.ingredients,
      required this.mixer,
      required this.notes,
      required this.minutes,
      required this.status});
}
