import 'dart:developer';

import 'package:mysql1/mysql1.dart';
import 'dart:async';

class Database {
  Future<MySqlConnection> getSettings() async
  {
    return await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        db: 'fitlife',
        password: 'fitlife'));
  }
}

void addUser(var email, var password, var name, var handle) async {
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("INSERT INTO `fitlife`.`user` (`name`, `handle`, `email`, `password`) VALUES ('$name', '$handle', '$email', '$password');");
  await conn.close();
}

void deleteUser(var email) async
{
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("DELETE FROM `fitlife`.`user` WHERE (`email` = '$email');");
  await conn.close();
}

//need to test this with edit button when UI gets pushed
void updateUser(var email, var handle, var password, var name) async
{
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("UPDATE `fitlife`.`user` SET `name` = '$name', `handle` = '$handle',  `password` = '$password' WHERE (`email` = '$email');");
  await conn.close();
}

void logIn(var email, var password) async
{
  Database db = Database();
  var conn = await db.getSettings();

  var result = await conn.query('SELECT id FROM user;');
  print(result);
  // log("res: ${result['password']}");
  // print("len: ${result.toList()}");
  print("empty: ${result.isEmpty}");
  print("toS: ${result.toString()}");
  print("aff: ${result.affectedRows}");





  // log(result.first.toString());
  // log("password $password");
  // log("email $email");
  // log("result ${result.first}" );
  // log("result ${result.first.toString()}");
  // if(result == password)
  // {
  //   return true;
  // }
  for(var res in result)
  {
    print("res: ${res['password']}");
    print(res.toString());
  //   if(password == res['password'])
  //   {
  //       return true;
    }

  // }
  // for (var i = 0; i < result.length; i++) {
  //   // log(result.first);
  //   print(result.first);
  //   // Do something with each result
  // }

  await conn.close();

  // return false;
}

Future<bool> emailExists(var email) async
{
  Database db = Database();
  var conn = await db.getSettings();

  var result = await conn.query("SELECT * FROM `fitlife`.`user` WHERE (`email` = '$email');");

  //something like if result returns something --> return true

  await conn.close();
  return false;
}