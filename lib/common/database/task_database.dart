import 'package:flutter_reccuring_reminder/common/entities/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();
  static Database? _database;
  TasksDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('task.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT';
    const intType = 'INTEGER';
    await db.execute('''
      CREATE TABLE $tableTasks ( 
      ${TaskFields.id} $idType,
      ${TaskFields.title} $textType,
      ${TaskFields.body} $textType,
      ${TaskFields.recurrence} $textType,
       ${TaskFields.dateTime} $intType
      )
    ''');
  }

  Future<void> create(Task task) async {
    final db = await instance.database;
    await db.insert(
      tableTasks,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableTasks);
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i][TaskFields.id],
        title: maps[i][TaskFields.title],
        body: maps[i][TaskFields.body],
        recurrence: maps[i][TaskFields.recurrence],
        dateTime: maps[i][TaskFields.dateTime],
      );
    });
  }

  Future<int> update(Task task) async {
    final db = await instance.database;

    return db.update(
      tableTasks,
      task.toMap(),
      where: '${TaskFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableTasks,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
