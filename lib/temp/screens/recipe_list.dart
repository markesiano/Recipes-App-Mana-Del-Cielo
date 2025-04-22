import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './add_recipe.dart';
import '../models/recipe.dart';
import '../screens/recipe_detail.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? recipesString = prefs.getString('recipess');

    if (recipesString != null) {
      final List<dynamic> recipeJson = jsonDecode(recipesString);
      setState(() {
        _recipes.clear();
        _recipes
            .addAll(recipeJson.map((json) => Recipe.fromJson(json)).toList());
      });
    }
  }

  Future<void> _saveRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String recipesString =
        jsonEncode(_recipes.map((r) => r.toJson()).toList());
    prefs.setString('recipess', recipesString);
  }

  void _addRecipe(Recipe recipe) {
    setState(() {
      _recipes.add(recipe);
    });
    _saveRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Recetario'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AddRecipeScreen(),
              ),
            );
            if (result != null && result is Recipe) {
              _addRecipe(result);
            }
          },
        ),
      ),
      child: SafeArea(
        child: _recipes.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No tienes recetas aún. Agrega una nueva!',
                    style: TextStyle(
                        fontSize: 18, color: CupertinoColors.inactiveGray),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return CupertinoListTile(
                    title: Text(
                      recipe.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            recipe: recipe,
                            onDelete: (recipe) {
                              setState(() {
                                _recipes.remove(recipe);
                              });
                              _saveRecipes();
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
