// Create class of ingredient
class Ingredient {
  int? id;
  String? name;
  double? quantity; // Grams - Milliliters

  Ingredient({this.id, this.name, this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}
