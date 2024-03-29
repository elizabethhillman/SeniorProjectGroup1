import 'package:fitlife/model/User.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:async';

class Database {
  Future<MySqlConnection> getSettings() async
  {
    return await MySqlConnection.connect(ConnectionSettings(
          host: '10.0.2.2',/// android emulator
        //host: 'localhost',///ios emulator
        port: 3306,
        user: 'root',
        db: 'fitlife',
        password: 'fitlife'));
  }
}

void addUser(var email, var password, var name, var handle, var trainer, var profilePic) async {
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("INSERT INTO `fitlife`.`user` (`name`, `handle`, `email`, `password`, `bio`, `followers`, `following`, `trainer`, `profilePic` ) VALUES ('$name', '$handle', '$email', '$password', '', '','', '$trainer', '$profilePic');");
  //idk why this works but needs both select statements
  var id = await conn.query("SELECT * from fitlife.user;");
  var result = await conn.query('SELECT MAX(id) FROM fitlife.user;');
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

void updateUser(int id, var email, var handle, var password, var name, var bio, var trainer) async
{
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("UPDATE `fitlife`.`user` SET `name` = '$name', `handle` = '$handle',  `password` = '$password', `bio` = '$bio', `trainer` = '$trainer' WHERE (`id` = '$id');");
  await conn.close();
}

void updateProfilePic(int id, var profilePic) async
{
  Database db = Database();
  var conn = await db.getSettings();
  print(profilePic);
  await conn.query("UPDATE `fitlife`.`user` SET `profilePic` = '$profilePic' WHERE (`id` = '$id');");
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

Future<String> getProfilePic(String email) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT email, profilePic FROM fitlife.user;');
  for(var res in result)
  {
    if(email.compareTo(res['email'])==0)
    {
      return res['profilePic'];
    }
  }

  await conn.close();

  return " ";
}

Future<String> getTrainerStatus(String email) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT trainer, email, handle FROM fitlife.user;');
  for(var res in result)
  {
    if(email.compareTo(res['email'])==0)
    {
      return res['trainer'];
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
  var result = await conn.query('SELECT handle, trainer FROM fitlife.user;');
  final List<String> allResults = [];
  for(var res in result) {
    if (res['trainer'] == "false") {
      var val = res['handle'];
      if (val.contains(input) && val != userHandle) {
        allResults.add(val);
      }
    }
  }

  await conn.close();

  return allResults;
}

Future<List<String>> findTrainer(var input, var userHandle) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.user");
  var result = await conn.query('SELECT handle, trainer FROM fitlife.user;');
  final List<String> allResults = [];
  for(var res in result) {
    if (res['trainer'] == "true") {
      var val = res['handle'];
      if (val.contains(input) && val != userHandle) {
        allResults.add(val);
      }
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
      data.add(res['trainer']);
      data.add(res['profilePic']);
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
          "UPDATE `fitlife`.`user` SET `followers` = '$followers,$searching' WHERE (`handle` = '${current
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
  String follower = await getFollowers(current.email);
  print(follower);
  Database db = Database();
  var conn = await db.getSettings();
  List<String> all = follower.split(",");
  for(int i = 0; i < all.length; i++) {
    all[i] = all[i].replaceAll(" ", '');
  }
  if(all.contains(searching)) {
    print(all);
    if(all.length>1)
    {
      await conn.query(
          "UPDATE `fitlife`.`user` SET `followers` = REPLACE('$follower', ',$searching', '') WHERE (`handle` = '${current
              .handle}');");
      print("here");
    }
    else {
      await conn.query(
          "UPDATE `fitlife`.`user` SET `followers` = REPLACE('$follower', '$searching', '') WHERE (`handle` = '${current
              .handle}');");
    }}
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
          "UPDATE `fitlife`.`user` SET `following` = '$following,$newFriendHandle' WHERE (`handle` = '${u
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
  String following = await getFollowing(current.email);
  print("following: $following");
  Database db = Database();
  var conn = await db.getSettings();
  List<String> all = following.split(",");
  for(int i = 0; i < all.length; i++) {
    all[i] = all[i].replaceAll(" ", '');
  }
  if(all.contains(searching)) {
    print("see it");
    if(all.length>1)
    {
      print(">1");
      await conn.query(
          "UPDATE `fitlife`.`user` SET `following` = REPLACE('$following', ',$searching', '') WHERE (`handle` = '${current
              .handle}');");
    }
    else {
      print("<1");
      print(searching);
      await conn.query(
          "UPDATE `fitlife`.`user` SET `following` = REPLACE('$following', '$searching', '') WHERE (`handle` = '${current
              .handle}');");
    }}
  await conn.close();
}


