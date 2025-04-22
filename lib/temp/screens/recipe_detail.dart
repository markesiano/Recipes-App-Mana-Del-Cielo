import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  final Function(Recipe) onDelete;

  const RecipeDetailScreen({
    Key? key,
    required this.recipe,
    required this.onDelete,
  }) : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final TextEditingController _percentageController = TextEditingController();
  double _percentage = 100;

  @override
  void dispose() {
    _percentageController.dispose();
    super.dispose();
  }

  List<double> _calculateIngredientPercentages() {
    return widget.recipe.ingredients
        .map((ingredient) => (ingredient.cantidad * _percentage) / 100)
        .toList();
  }

  void _deleteRecipe() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Eliminar receta'),
          content:
              const Text('¿Estás seguro de que quieres eliminar esta receta?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                widget.onDelete(widget.recipe);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<double> ingredientPercentages = _calculateIngredientPercentages();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.recipe.title),
        trailing: GestureDetector(
          onTap: _deleteRecipe,
          child: const Icon(CupertinoIcons.delete),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              const Text(
                'Ingredientes:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              ...widget.recipe.ingredients.asMap().entries.map((entry) {
                int index = entry.key;
                Ingredient ingredient = entry.value;
                return CupertinoListTile(
                  title: Text(ingredient.name,
                      style: const TextStyle(fontSize: 18)),
                  subtitle: Text(
                    'Cantidad: ${ingredient.cantidad} (${ingredientPercentages[index].toStringAsFixed(1)})',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _percentageController,
                placeholder: 'Porcentaje (1-1000)',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _percentage = double.tryParse(value) ?? 100;
                    if (_percentage < 1) {
                      _percentage = 1;
                    } else if (_percentage > 1000) {
                      _percentage = 1000;
                    }
                  });
                },
                padding: const EdgeInsets.symmetric(horizontal: 12),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Mezclador:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 4),
              Text(widget.recipe.mixer.name,
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              const Text(
                'Herramienta utilizada:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 4),
              Text(widget.recipe.mixer.tool.name,
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              Text(
                'Tiempo de preparación: ${widget.recipe.minutes} minutos',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Notas:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 4),
              Text(widget.recipe.notes, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
