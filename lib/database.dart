import 'package:mysql1/mysql1.dart';
import 'dart:async';

class Database {
  Future main() async
  {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'fitlife',
        db: 'fitlife'
    ));
  }
}
