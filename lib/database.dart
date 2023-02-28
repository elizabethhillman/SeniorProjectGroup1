import 'package:mysql1/mysql1.dart';
import 'dart:async';

// class Database {
//   Future<MySqlConnection> getSettings() async
//   {
//     return await MySqlConnection.connect(ConnectionSettings(
//         host: 'localhost',
//         port: 3306,
//         user: 'root',
//         db: 'fitlife',
//         password: 'fitlife'));
//   }
// }


void addUser(var email, var password, var name) async {
  var conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'fitlife',
      password: 'fitlife'));

  // await conn.query(
  //     'CREATE TABLE if not exists users (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(255), email varchar(255), password varchar(255))');

  await conn.query("INSERT INTO `fitlife`.`user` (`name`, `email`, `password`) VALUES ('$name', '$email', '$password');");
  await conn.close();
}

Future<bool> foundUser(var email, var password) async
{
  var conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'fitlife',
      password: 'fitlife'));

  var result = await conn.query("SELECT `email` AND `password` FROM `fitlife`.`user`;");

  print(result);
  for(var res in result)
  {
    if(email == res[0])
    {
      if(password == res[1])
      {
        return true;
      }
    }
  }
  await conn.close();

  return false;
}