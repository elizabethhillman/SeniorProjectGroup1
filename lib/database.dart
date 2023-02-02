import 'package:mysql1/mysql1.dart';
import 'dart:async';

class DB {
  static int insertId = -1;
}

//https://pub.dev/packages/mysql1/example
Future addUser(String email, String password, String name) async {
  var conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'fitlife',
      password: 'fitlife'));

  Future.delayed(const Duration(seconds: 1));

  await conn.query(
      'CREATE TABLE IF NOT EXISTS user (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, email varchar(45), password varchar(45), name varchar(45))');

  ///google said someone had same issue so added delays but that no worked for me
  Future.delayed(const Duration(seconds: 1));

  ///the range error(byteOffset) issue is with the , [e,p,n] but its required by conn.query so idk
  ///i also tried just like insert into user (e,p,n) values ($email, $pass, $name) and there's no errors but doesn't add it
  var result = await conn!.query(
      'insert into user (email, password, name) values (?,?,?)',
      [email, password, name]);
  DB.insertId = result.insertId!;
  return await conn.close();
}
