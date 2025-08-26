import 'package:sqflite/sqflite.dart'
    if (dart.library.io) 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('gym_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    final db = await openDatabase(path, version: 1, onCreate: _createDB);
    await addRepsSetsColumnsIfNeeded(db); // Ensure columns exist after DB open
    return db;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE exercises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workout_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        reps TEXT,
        sets TEXT,
        FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE
      )
    ''');

    // New: Create meal_plans table
    await db.execute('''
      CREATE TABLE meal_plans (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        day TEXT NOT NULL,
        morning_title TEXT,
        morning_protein REAL,
        morning_carbs REAL,
        morning_fat REAL,
        morning_description TEXT,
        lunch_title TEXT,
        lunch_protein REAL,
        lunch_carbs REAL,
        lunch_fat REAL,
        lunch_description TEXT,
        dinner_title TEXT,
        dinner_protein REAL,
        dinner_carbs REAL,
        dinner_fat REAL,
        dinner_description TEXT
      )
    ''');
  }

  // Add reps and sets columns if they don't exist
  Future<void> addRepsSetsColumnsIfNeeded(Database db) async {
    try {
      await db.execute('ALTER TABLE exercises ADD COLUMN reps TEXT;');
    } catch (e) {
      // Ignore error if column already exists
    }
    try {
      await db.execute('ALTER TABLE exercises ADD COLUMN sets TEXT;');
    } catch (e) {
      // Ignore error if column already exists
    }
  }

  Future<int> insertWorkout(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('workouts', row);
  }

  Future<List<Map<String, dynamic>>> queryAllWorkouts() async {
    final db = await instance.database;
    return await db.query('workouts');
  }

  Future<int> updateWorkout(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('workouts', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteWorkout(int id) async {
    final db = await instance.database;
    return await db.delete('workouts', where: 'id = ?', whereArgs: [id]);
  }

  // Add CRUD methods for meal plans
  Future<int> insertMealPlan(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('meal_plans', row);
  }

  Future<List<Map<String, dynamic>>> queryAllMealPlans() async {
    final db = await instance.database;
    return await db.query('meal_plans');
  }

  Future<int> updateMealPlan(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('meal_plans', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteMealPlan(int id) async {
    final db = await instance.database;
    return await db.delete('meal_plans', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
