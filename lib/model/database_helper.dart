// Import required packages
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// DatabaseHelper class - Singleton pattern
class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  
  // Private constructor
  DatabaseHelper._init();
  
  // Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('myapp.db');
    return _database!;
  }
  
  // Initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
  
  // Create database tables
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE habits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        rewardReq TEXT,
        penaltyReq TEXT,
        frequency TEXT,
        streak INTEGER DEFAULT 0
      )
    ''');
  }
  
  // CREATE - Insert new item
  Future<int> createItem(Map<String, dynamic> item) async {
    final db = await database;
    return await db.insert('habits', item);
  }
  
  // READ - Get all items
  Future<List<Map<String, dynamic>>> getAllItems() async {
    final db = await database;
    return await db.query('habits', orderBy: 'name ASC');
  }
  
  // READ - Get single item by ID
  Future<Map<String, dynamic>?> getItem(int id) async {
    final db = await database;
    final results = await db.query(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }
  
  // UPDATE - Update existing item
  Future<int> updateItem(int id, Map<String, dynamic> item) async {
    final db = await database;
    return await db.update(
      'habits',
      item,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // DELETE - Remove item
  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // Close database connection
  Future close() async {
    final db = await database;
    db.close();
  }
}