import '../../domain/entities/Mixer.dart';

class MixDetailViewModel {
  int id;
  String title;
  String description;
  List ingredients;
  Mixer mixer;
  int minutes;
  String notes;
  MixDetailViewModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.ingredients,
      required this.mixer,
      required this.minutes,
      required this.notes});
}
