import 'package:fitlife/model/User.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:async';

class Database {
  Future<MySqlConnection> getSettings() async
  {
    return await MySqlConnection.connect(ConnectionSettings(
        // host: '10.0.2.2',//android emulator
        host: 'localhost',//ios emulator
        port: 3306,
        user: 'root',
        db: 'fitlife',
        password: 'fitlife'));
  }
}

void addUser(var email, var password, var name, var handle) async {
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("INSERT INTO `fitlife`.`user` (`name`, `handle`, `email`, `password`, `bio`, `followers`, `following`) VALUES ('$name', '$handle', '$email', '$password', '', '','' );");
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

void updateUser(int id, var email, var handle, var password, var name, var bio) async
{
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("UPDATE `fitlife`.`user` SET `name` = '$name', `handle` = '$handle',  `password` = '$password', `bio` = '$bio' WHERE (`id` = '$id');");
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

Future<String> getBio(String email) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT bio,email FROM fitlife.user;');
  for(var res in result)
  {
    if(email.compareTo(res['email'])==0)
    {
      return res['bio'];
    }
  }

  await conn.close();

  return "";
}

Future<String> getFollowers(String email) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT followers, email FROM fitlife.user;');
  for(var res in result)
  {
    if(email.compareTo(res['handle'])==0)
    {
      return res['followers'];
    }
  }

  await conn.close();

  return "-1";
}

Future<String> getFollowing(String email) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT following, email FROM fitlife.user;');
  for(var res in result)
  {
    if(email.compareTo(res['handle'])==0)
    {
      return res['following'];
    }
  }

  await conn.close();

  return "-1";
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

Future<bool> handleExists(var handle) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT handle FROM fitlife.user;');
  for(var res in result)
  {
    if(handle.compareTo(res['handle'])==0)
    {
      return true;
    }
  }

  await conn.close();

  return false;
}

Future<List<String>> findFriend(var input, var userHandle) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT handle FROM fitlife.user;');
  final List<String> allResults = [];
  for(var res in result)
  {
    var val = res['handle'];
    if(val.contains(input) && val != userHandle){
      allResults.add(val);
    }
  }

  await conn.close();

  return allResults;
}

Future<List<String>> searchingByHandle(String handle) async
{
  final List<String> data = [];
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT * FROM fitlife.user;');
  for(var res in result)
  {
    if(handle.compareTo(res['handle'])==0)
    {
      data.add(res['handle']);
      data.add(res['followers']);
      data.add(res['following']);
      data.add(res['bio']);
      data.add(res['email']);
    }
  }

  await conn.close();

  return data;
}

void addFollower(User current, String searching) async
{
  String followers = await getFollowers(current.handle);
  Database db = Database();
  var conn = await db.getSettings();
  List<String> all = followers.split(",");
  if(!all.contains(searching)) {
    if (followers.isNotEmpty) {
      await conn.query(
          "UPDATE `fitlife`.`user` SET `followers` = '$followers, $searching' WHERE (`handle` = '${current
              .handle}');");
    }
    else {
      await conn.query(
          "UPDATE `fitlife`.`user` SET `followers` = '$searching' WHERE (`handle` = '${current
              .handle}');");
    }
  }

  String fol = await getFollowers(current.handle);
  current.followers = fol;

  await conn.close();
}

void removeFollower(User current, String searching) async
{
  String followers = await getFollowers(current.handle);
  Database db = Database();
  var conn = await db.getSettings();
  List<String> all = followers.split(",");
  for (int i = 0; i < all.length; i++) {
    all[i] = all[i].replaceAll(" ", '');
  }
  if (all.contains(searching)) {
    if (all.contains(searching)) {
      await conn.query("UPDATE `fitlife`.`user` SET `followers` = REPLACE('$followers', '$searching', '') WHERE (`handle` = '${current.handle}');");
    }
    await conn.close();
  }
}

void addFollowing(User u, String newFriendHandle) async
{
  String following = await getFollowing(u.handle);
  Database db = Database();
  var conn = await db.getSettings();
  List<String> all = following.split(",");
  if(!all.contains(newFriendHandle)) {
    if (following.isNotEmpty) {
      await conn.query(
          "UPDATE `fitlife`.`user` SET `following` = '$following, $newFriendHandle' WHERE (`handle` = '${u
              .handle}');");
    }
    else {
      await conn.query(
          "UPDATE `fitlife`.`user` SET `following` = '$newFriendHandle' WHERE (`handle` = '${u
              .handle}');");
    }
  }

  String fol = await getFollowing(u.handle);
  u.following = fol;

  await conn.close();
}

void removeFollowing(User current, String searching) async
{
  String following = await getFollowing(current.handle);
  Database db = Database();
  var conn = await db.getSettings();
  List<String> all = following.split(",");
  for(int i = 0; i < all.length; i++) {
    all[i] = all[i].replaceAll(" ", '');
  }
  if(all.contains(searching)) {
    if(all.length>1)
    {
      await conn.query(
          "UPDATE `fitlife`.`user` SET `following` = REPLACE('$following', ', $searching', '') WHERE (`id` = '${current
              .id}');");
    }
    else {
      await conn.query(
          "UPDATE `fitlife`.`user` SET `following` = REPLACE('$following', '$searching', '') WHERE (`id` = '${current
              .id}');");
    }}
  await conn.close();
}


