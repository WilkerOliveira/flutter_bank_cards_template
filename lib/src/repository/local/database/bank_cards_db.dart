import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bank_cards/src/repository/local/database/model/storage.dart';

class BankCardsDatabase {
  static final BankCardsDatabase _instance = BankCardsDatabase._();
  static Database _database;
  static const _TB_NAME = "tb_bank_cards";

  BankCardsDatabase._();

  factory BankCardsDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }

    _database = await init();

    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'bankcards.db');
    var database = openDatabase(dbPath,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $_TB_NAME(
        name TEXT PRIMARY KEY,
        value TEXT)
    ''');
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  Future<int> save(Storage storage) async {
    var client = await db;

    var returnValue = client.insert(_TB_NAME, storage.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return returnValue;
  }

  Future<Storage> fetchData(String key) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
        client.query(_TB_NAME, where: 'name = ?', whereArgs: [key]);
    var maps = await futureMaps;

    if (maps.length != 0) {
      return Storage.fromDb(maps.first);
    }

    return null;
  }

  Future<List<Storage>> fetchAll() async {
    var client = await db;
    var res = await client.query(_TB_NAME);

    if (res.isNotEmpty) {
      var cars = res.map((carMap) => Storage.fromDb(carMap)).toList();
      return cars;
    }
    return [];
  }

  Future<void> remove(String name) async {
    var client = await db;
    return client.delete(_TB_NAME, where: 'name = ?', whereArgs: [name]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }
}
