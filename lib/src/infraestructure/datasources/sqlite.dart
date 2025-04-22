import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/entities/Mix.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/entities/Mixer.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/entities/Tool.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/entities/Ingredient.dart';
import 'package:recipes_app_mana_del_cielo/src/data/interfaces/IDataSource.dart';

// Using Singleton

class SqliteDataSource extends IDataSource<Mix> {
  late Future<Database> database;

  static final instance = SqliteDataSource();

// Inicialización de la base de datos con las tablas necesarias.
  SqliteDataSource() {
    database = openDatabase(
      'databaseRecipes1.db',
      version: 1,
      onCreate: (db, version) {
        // Crear tabla de Mixes
        db.execute('''
        CREATE TABLE mixes (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          title TEXT NOT NULL,
          description TEXT,
          mixer_id INTEGER,
          minutes INTEGER,
          notes TEXT,
          status INTEGER,
          FOREIGN KEY(mixer_id) REFERENCES mixers(id)
        )
      ''');

        // Crear tabla de Ingredients
        db.execute('''
        CREATE TABLE ingredients (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT NOT NULL,
          quantity REAL
        )
      ''');

        // Crear tabla de Mix_Ingredients para la relación muchos a muchos
        db.execute('''
        CREATE TABLE mix_ingredients (
          mix_id INTEGER NOT NULL,
          ingredient_id INTEGER NOT NULL,
          FOREIGN KEY(mix_id) REFERENCES mixes(id),
          FOREIGN KEY(ingredient_id) REFERENCES ingredients(id),
          PRIMARY KEY(mix_id, ingredient_id)
        )
      ''');

        // Crear tabla de Mixers
        db.execute('''
        CREATE TABLE mixers (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT NOT NULL,
          description TEXT,
          tool_id INTEGER,
          FOREIGN KEY(tool_id) REFERENCES tools(id)
        )
      ''');

        // Crear tabla de Tools
        db.execute('''
        CREATE TABLE tools (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT NOT NULL,
          description TEXT
        )
      ''');
      },
    );
  }

  static SqliteDataSource get() {
    return instance;
  }

  @override
  Future<Mix> create(Mix mix) async {
    final db = await database;
    // Insertar el mixer y obtener el ID
    int mixerId = await db.insert('mixers', mix.mixer.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    // Insertar la mezcla y asociar el mixer_id
    int mixId = await db.insert(
        'mixes',
        {
          'title': mix.title,
          'description': mix.description,
          'mixer_id': mixerId,
          'minutes': mix.minutes,
          'notes': mix.notes,
          'status': 1 // Status activo
        },
        conflictAlgorithm: ConflictAlgorithm.replace);

    // Insertar los ingredientes en la tabla ingredients y crear la relación en mix_ingredients
    for (var ingredient in mix.ingredients) {
      int ingredientId = await db.insert('ingredients', ingredient.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      // Relacionar el ingrediente con la mezcla en la tabla mix_ingredients
      await db.insert('mix_ingredients', {
        'mix_id': mixId,
        'ingredient_id': ingredientId,
      });
    }

    // Retornar el objeto Mix creado
    return Mix(
      id: mixId,
      title: mix.title,
      description: mix.description,
      ingredients: mix.ingredients,
      mixer: mix.mixer,
      minutes: mix.minutes,
      notes: mix.notes,
    );
  }

  @override
  Future<void> delete(int id) async {
    final db = await database;
    // Cambiar el campo "status" a 0 para indicar que la mezcla no está disponible
    await db.update('mixes', {'status': 0}, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Mix>> getAll() async {
    final db = await database;
    final List<Map<String, dynamic>> mixMaps =
        await db.query('mixes', where: 'status = ?', whereArgs: [1]);

    List<Mix> mixes = [];

    for (var mixMap in mixMaps) {
      // Obtener el mixer asociado
      final mixerMap = await db
          .query('mixers', where: 'id = ?', whereArgs: [mixMap['mixer_id']]);
      Mixer mixer = Mixer(
        id: int.parse((mixerMap[0]['id']).toString()),
        name: mixerMap[0]['name'].toString(),
        description: mixerMap[0]['description'].toString(),
        tool: await _getTool(int.parse(mixerMap[0]['tool_id'].toString())),
      );

      // Obtener los ingredientes asociados
      final List<Map<String, dynamic>> ingredientMaps = await db.rawQuery(
          'SELECT ingredients.* FROM ingredients '
          'INNER JOIN mix_ingredients ON ingredients.id = mix_ingredients.ingredient_id '
          'WHERE mix_ingredients.mix_id = ?',
          [mixMap['id']]);
      List<Ingredient> ingredients = ingredientMaps
          .map((map) => Ingredient(
                id: map['id'],
                name: map['name'],
                quantity: map['quantity'],
              ))
          .toList();

      // Añadir el Mix a la lista
      mixes.add(Mix(
        id: mixMap['id'],
        title: mixMap['title'],
        description: mixMap['description'],
        ingredients: ingredients,
        mixer: mixer,
        minutes: mixMap['minutes'],
        notes: mixMap['notes'],
      ));
    }

    return mixes;
  }

  @override
  Future<Mix> getOne(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> mixMaps =
        await db.query('mixes', where: 'id = ?', whereArgs: [id]);

    if (mixMaps.isEmpty) throw Exception('Mix not found');

    // Obtener el mixer asociado
    final mixerMap = await db
        .query('mixers', where: 'id = ?', whereArgs: [mixMaps[0]['mixer_id']]);
    Mixer mixer = Mixer(
      id: int.parse(mixerMap[0]['id'].toString()),
      name: mixerMap[0]['name'].toString(),
      description: mixerMap[0]['description'].toString(),
      tool: await _getTool(int.parse(mixerMap[0]['tool_id'].toString())),
    );

    // Obtener los ingredientes asociados
    final List<Map<String, dynamic>> ingredientMaps = await db.rawQuery(
        'SELECT ingredients.* FROM ingredients '
        'INNER JOIN mix_ingredients ON ingredients.id = mix_ingredients.ingredient_id '
        'WHERE mix_ingredients.mix_id = ?',
        [id]);
    List<Ingredient> ingredients = ingredientMaps
        .map((map) => Ingredient(
              id: map['id'],
              name: map['name'],
              quantity: map['quantity'],
            ))
        .toList();

    return Mix(
      id: mixMaps[0]['id'],
      title: mixMaps[0]['title'],
      description: mixMaps[0]['description'],
      ingredients: ingredients,
      mixer: mixer,
      minutes: mixMaps[0]['minutes'],
      notes: mixMaps[0]['notes'],
    );
  }

  @override
  Future<Mix> update(Mix mix) async {
    final db = await database;

    // Actualizar la información de la mezcla
    await db.update(
        'mixes',
        {
          'title': mix.title,
          'description': mix.description,
          'mixer_id': mix.mixer.id,
          'minutes': mix.minutes,
          'notes': mix.notes,
          'status': 1
        },
        where: 'id = ?',
        whereArgs: [mix.id]);

    // Actualizar los ingredientes
    for (var ingredient in mix.ingredients) {
      await db.update('ingredients', ingredient.toMap(),
          where: 'id = ?', whereArgs: [ingredient.id]);
    }

    return mix;
  }

// Método auxiliar para obtener el Tool asociado
  Future<Tool> _getTool(int toolId) async {
    final db = await database;
    final toolMap =
        await db.query('tools', where: 'id = ?', whereArgs: [toolId]);

    return Tool(
      id: int.parse(toolMap[0]['id'].toString()),
      name: toolMap[0]['name'].toString(),
      description: toolMap[0]['description'].toString(),
    );
  }
}
