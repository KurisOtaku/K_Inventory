// ignore_for_file: file_names, unused_import, unused_local_variable

import 'dart:async';
import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import '../produto_coletado.dart';
import 'Entity/Pesquisa.dart';

void testeDB() async {
  /*
  OPEN DATABASE
  */
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.

  final database = await createDB();

// TESTE
  List produtosExemplo = [];
  for (int i = 0; i < 1; i++) {
    produtosExemplo.add(Item(
        id: 0,
        cod: _randInt(930, 25000),
        nameProd: 'Prod Aleatorio' + _randInt(930, 25000).toString() + 'RGB',
        qtP: _randInt(0, 11),
        qtL: _randInt(0, 11),
        qtC: _randInt(0, 15),
        qtU: _randInt(0, 11),
        validade: _randInt(1, 28).toString() +
            "/" +
            _randInt(3, 12).toString() +
            "/2022"));
    produtosExemplo.add(Item(
        id: 0,
        cod: _randInt(930, 25000),
        nameProd: 'Aleatorio ' + _randInt(930, 25000).toString() + ' P2L',
        qtP: _randInt(0, 11),
        qtL: _randInt(0, 11),
        qtC: _randInt(0, 15),
        qtU: _randInt(0, 11),
        validade: _randInt(1, 28).toString() +
            "/" +
            _randInt(3, 12).toString() +
            "/2022"));
  }
  await insertItem(produtosExemplo[0], database);
  await insertItem(produtosExemplo[1], database);

  print(await selectItens(database));
}

_randInt(int min, int max) {
  final _random = Random();
  int next(int min, int max) => min + _random.nextInt(max - min);
  return next(min, max);
}

createDB() async {
  openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'inventario.db'),

    /*
  CREATE TABLE
*/
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE pesquisa(id INTEGER PRIMARY KEY, cod INTEGER, name TEXT, qtP INTEGER, qtL INTEGER, qtC INTEGER, qtU INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
}

// Define a function that inserts dogs into the database
Future<void> insertItem(Item produto, database) async {
  // Get a reference to the database.
  final db = await database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'pesquisa',
    produto.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// A method that retrieves all the dogs from the dogs table.
Future<List<Item>> selectItens(database) async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('pesquisa');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Item(
      id: maps[i]['id'],
      cod: maps[i]['cod'],
      nameProd: maps[i]['nameProd'],
      qtP: maps[i]['qtP'],
      qtL: maps[i]['qtL'],
      qtC: maps[i]['qtC'],
      qtU: maps[i]['qtU'],
      validade: maps[i]['validade'],
    );
  });
}
