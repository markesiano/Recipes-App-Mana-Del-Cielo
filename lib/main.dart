import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Necesario para el uso de algunos widgets como RecipeListScreen
import 'temp/screens/recipe_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Recetario',
      home: RecipeListScreen(),
    );
  }
}
