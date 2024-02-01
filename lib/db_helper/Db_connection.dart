import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  Future<Database> setDatabase() async {
    var database;
    try {
      var directory = await getApplicationDocumentsDirectory();
      var path = join(directory.path, 'db_user');
      database = openDatabase(path, version: 1, onCreate: _createDatabase);
    } on Exception catch (e) {
      print('sumthing wrong in the onCreate database method $e');
    }
    return database;
  }

  _createDatabase(Database database, int version) async {
    String sql =
        'CREATE TABLE users(id INTEGER PRIMARY KEY ,name TEXT,contact TEXT,description TEXT)';
    await database.execute(sql);
  }
}
