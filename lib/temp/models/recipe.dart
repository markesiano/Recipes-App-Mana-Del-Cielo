class Recipe {
  final int id;
  final String title;
  final String description;
  final List<Ingredient> ingredients;
  final Mixer mixer;
  final int minutes;
  final String notes;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.mixer,
    required this.minutes,
    required this.notes,
  });

  // Convertir un objeto Recipe a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
      'mixer': mixer.toJson(),
      'minutes': minutes,
      'notes': notes,
    };
  }

  // Crear un objeto Recipe desde JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      ingredients: (json['ingredients'] as List)
          .map((i) => Ingredient.fromJson(i))
          .toList(),
      mixer: Mixer.fromJson(json['mixer']),
      minutes: json['minutes'],
      notes: json['notes'],
    );
  }
}

class Ingredient {
  final int id;
  final String name;
  final int cantidad;

  Ingredient({required this.id, required this.name, required this.cantidad});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cantidad': cantidad,
    };
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      cantidad: json['cantidad'],
    );
  }
}

class Mixer {
  final int id;
  final String name;
  final String description;
  final Tool tool;

  Mixer(
      {required this.id,
      required this.name,
      required this.description,
      required this.tool});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'tool': tool.toJson(),
    };
  }

  factory Mixer.fromJson(Map<String, dynamic> json) {
    return Mixer(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      tool: Tool.fromJson(json['tool']),
    );
  }
}

class Tool {
  final int id;
  final String name;
  final String description;

  Tool({required this.id, required this.name, required this.description});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Tool.fromJson(Map<String, dynamic> json) {
    return Tool(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
