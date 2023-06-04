// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._instance();
//   static Database? _db = null;

//   DatabaseHelper._instance();

//   String users = 'users';
//   String colId = 'id';
//   String username = 'username';
//   String colPassword = 'password';

//   Future<Database> get db async {
//     if (_db == null) {
//       _db = await _initDb();
//     }
//     return _db!;
//   }

//   Future<Database> _initDb() async {
//     String dbPath = await getDatabasesPath();
//     String path = join(dbPath, 'my_database.db');
//     final database = await openDatabase(path, version: 1, onCreate: _createDb);
//     return database;
//   }

//   void _createDb(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE $users($colId INTEGER PRIMARY KEY AUTOINCREMENT, $username TEXT, $colPassword TEXT)');
//   }

//   Future<List<Map<String, dynamic>>> getUserMapList() async {
//     Database db = await this.db;
//     final List<Map<String, dynamic>> result = await db.query(users);
//     return result;
//   }

//   Future<int> insertUser(Map<String, dynamic> user) async {
//     Database db = await this.db;
//     final int result = await db.insert(users, user);
//     return result;
//   }

//   Future<int> updateUser(Map<String, dynamic> user) async {
//     Database db = await this.db;
//     final int result = await db
//         .update(users, user, where: '$colId = ?', whereArgs: [user[colId]]);
//     return result;
//   }

//   Future<int> deleteUser(int id) async {
//     Database db = await this.db;
//     final int result =
//         await db.delete(users, where: '$colId = ?', whereArgs: [id]);
//     return result;
//   }

//   Future<Map<String, dynamic>> getLastUser() async {
//     Database db = await this.db;
//     final List<Map<String, dynamic>> result =
//         await db.query(users, orderBy: '$colId DESC', limit: 1);
//     if (result.length == 0) {
//       return {'username': ''}; // valeur de retour par défaut
//     }
//     return result[0];
//   }
// }
