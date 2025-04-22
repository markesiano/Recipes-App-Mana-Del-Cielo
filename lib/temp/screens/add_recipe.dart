import 'package:flutter/cupertino.dart';
import '../models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  String _selectedMixer = 'Batidora';
  String _selectedTool = 'Pala';

  final List<String> _mixers = ['Batidora', 'Cazo'];
  final List<String> _tools = ['Pala', 'Globo', 'Gancho'];

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _minutesController = TextEditingController();
  final _notesController = TextEditingController();

  // Lista de ingredientes
  final List<Ingredient> _ingredients = [];
  final TextEditingController _ingredientNameController =
      TextEditingController();
  final TextEditingController _ingredientCantidadController =
      TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _minutesController.dispose();
    _notesController.dispose();
    _ingredientNameController.dispose();
    _ingredientCantidadController.dispose();
    super.dispose();
  }

  void _addIngredient() {
    final name = _ingredientNameController.text;
    final cantidad = int.tryParse(_ingredientCantidadController.text) ?? 0;

    if (name.isNotEmpty) {
      setState(() {
        _ingredients.add(Ingredient(
            id: _ingredients.length, name: name, cantidad: cantidad));
      });
      _ingredientNameController.clear();
      _ingredientCantidadController.clear();
    }
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      final newRecipe = Recipe(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        description: "",
        ingredients: _ingredients,
        mixer: Mixer(
          id: 0,
          name: _selectedMixer,
          description: "",
          tool: Tool(
            id: 0,
            name: _selectedTool,
            description: "",
          ),
        ),
        minutes: int.parse(_minutesController.text),
        notes: _notesController.text,
      );

      Navigator.pop(context, newRecipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Agregar Receta'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _saveRecipe,
          child: const Text('Guardar',
              style: TextStyle(color: CupertinoColors.activeBlue)),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              const Text('Información', style: TextStyle(fontSize: 18)),
              CupertinoTextField(
                controller: _titleController,
                placeholder: 'Título',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: _minutesController,
                placeholder: 'Minutos',
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: _notesController,
                placeholder: 'Notas',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text('Mezclador', style: TextStyle(fontSize: 18)),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CupertinoPicker(
                  itemExtent: 32,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedMixer = _mixers[index];
                    });
                  },
                  children: _mixers.map((mixer) {
                    return Center(
                        child:
                            Text(mixer, style: const TextStyle(fontSize: 16)));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Herramienta', style: TextStyle(fontSize: 18)),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CupertinoPicker(
                  itemExtent: 32,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedTool = _tools[index];
                    });
                  },
                  children: _tools.map((tool) {
                    return Center(
                        child:
                            Text(tool, style: const TextStyle(fontSize: 16)));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Ingredientes', style: TextStyle(fontSize: 18)),
              CupertinoTextField(
                controller: _ingredientNameController,
                placeholder: 'Nombre del Ingrediente',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: _ingredientCantidadController,
                placeholder: 'Cantidad',
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16),
              ),
              CupertinoButton(
                onPressed: _addIngredient,
                child: const Text('Agregar Ingrediente'),
              ),
              // Mostrar lista de ingredientes agregados
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = _ingredients[index];
                  return CupertinoListTile(
                    title: Text(ingredient.name),
                    subtitle: Text('Cantidad: ${ingredient.cantidad}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
