import 'package:fitlife/pages/User.dart';
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
  //idk why this works but needs both select statements
  var id = await conn.query("SELECT MAX(id) from fitlife.user;");
  var result = await conn.query('SELECT id FROM fitlife.user;');
  for(var res in result)
  {
    currentUser.id = res['MAX(id)'];
  }
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
void updateUser(int id, var email, var handle, var password, var name) async
{
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("UPDATE `fitlife`.`user` SET `name` = '$name', `handle` = '$handle',  `password` = '$password' WHERE (`id` = '$id');");
  await conn.close();
}

Future<bool> logIn(String email, var password) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT email, password FROM fitlife.user;');
  for(var res in result)
  {
    if(email.compareTo(res['email'])==0 && password.compareTo(res['password'])==0)
    {
      return true;
    }
  }

  await conn.close();

  return false;
}

Future<String> getName(String email, var password) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT name, email, password FROM fitlife.user;');
  for(var res in result)
  {
    if(email.compareTo(res['email'])==0 && password.compareTo(res['password'])==0)
    {
      return res['name'];
    }
  }

  await conn.close();

  return "";
}

Future<String> getHandle(String email, var password) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT handle, email, password FROM fitlife.user;');
  for(var res in result)
  {
    if(email.compareTo(res['email'])==0 && password.compareTo(res['password'])==0)
    {
      return res['handle'];
    }
  }

  await conn.close();

  return "";
}

Future<int> getID(String email, var password) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT id, email, password FROM fitlife.user;');
  for(var res in result)
  {
    if(email.compareTo(res['email'])==0 && password.compareTo(res['password'])==0)
    {
      return res['id'];
    }
  }

  await conn.close();

  return -2;
}

Future<bool> emailExists(var email) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT email FROM fitlife.user;');
  for(var res in result)
  {
    if(email.compareTo(res['email'])==0)
    {
      return true;
    }
  }

  await conn.close();

  return false;
}