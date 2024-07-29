import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/book.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "books_database.db";

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    print("Database path: $path"); // Debug log
    return await openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        author TEXT,
        coverImage TEXT,
        rating REAL,
        publicationDate TEXT,
        bio TEXT
      )
    ''');
    print("Table 'books' created."); // Debug log
  }

  Future<int> insertBook(Book book) async {
    final db = await database;
    int result = await db.insert(
      'books',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted book: $result"); // Debug log
    return result;
  }

  Future<List<Book>> getBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books');
    print("Books retrieved: ${maps.length}"); // Debug log
    return List.generate(maps.length, (index) => Book.fromMap(maps[index]));
  }

  Future<int> updateBook(Book book) async {
    final db = await database;
    int result = await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Updated book: $result"); // Debug log
    return result;
  }

  Future<int> deleteBook(int id) async {
    final db = await database;
    int result = await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
    print("Deleted book: $result"); // Debug log
    return result;
  }
}
