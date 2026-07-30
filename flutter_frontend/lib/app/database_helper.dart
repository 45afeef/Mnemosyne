import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), "mnemosyne.db");

    return openDatabase(
      path,
      version: 1,

      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE learning_goals(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          description TEXT,
          end_date TEXT,
          daily_commitment INTEGER,
          created_at TEXT NOT NULL
        )     
        ''');

        await db.execute('''
        CREATE TABLE syllabuses (
          id TEXT PRIMARY KEY NOT NULL,
          content TEXT NOT NULL,
          created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
          updated_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
        )
        ''');
      },
    );
  }
}
