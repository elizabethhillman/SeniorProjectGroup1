import 'package:mysql1/mysql1.dart';
import 'dart:async';
import 'package:fitlife/pages/user.dart';

//https://pub.dev/packages/mysql1/example
Future addUser(String name, String email, String pass) async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'fitlife',
      password: 'fitlife'));

  await conn.query(
      'CREATE TABLE IF NOT EXISTS user (email varchar(255) NOT NULL PRIMARY KEY, password varchar(255) NOT NULL, name varchar(255) NOT NULL)');

  await conn.query('insert into user (email, password, name) values (?, ?, ?)', [email, pass, name]);

  //
  // var result =  await conn.query('insert into user (email, password, name) values (?, ?, ?)', [email, pass, name]);
  //
  // for (var res in result) {
  //   final User newUser = User(
  //       email: res['email'].toString(), password: res['password'].toString(), name: res['name'].toString());
  //   myList.add(newUser);
  // }

  return await conn.close();
}

