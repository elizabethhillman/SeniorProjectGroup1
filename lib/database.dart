import 'package:mysql1/mysql1.dart';
import 'dart:async';

class Database
{
  Database();
  Future<MySqlConnection> getConnection() async {

    var settings = ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'fitlife',
        db: 'fitlife');

    return await MySqlConnection.connect(settings);

  }

}