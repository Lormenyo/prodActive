import 'package:path/path.dart';
import 'package:prodactive/todoListModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "todo.db";
  static final _databaseVersion = 1;

  static final table = 'todo';

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final status = 'isCompleted';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    print("creating db");
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
             $status INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insert(Task todo) async {
    Database db = await instance.database;
    var res = await db.insert(table, todo.toMap());
    return res;
  }

  Future<List<Task>> queryAllRows() async {
    List<Task> tasks = [];
    Database db = await instance.database;
    var res = await db.query(table, orderBy: "$columnId DESC");
    print(res);
    print(res.length);
    res.forEach((element) {
      tasks.insert(0, Task(taskTitle: element["title"]));
    });
    // print("printing tasks");
    // print(tasks);
    return tasks;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> clearTable() async {
    Database db = await instance.database;
    return await db.rawQuery("DELETE FROM $table");
  }
}
