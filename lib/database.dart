import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


// class Database
// {
//   static const db = Firebase.database;
//   static const users = db.ref().child("users");
//   static const newUser = "newUser";
//
//   users.child(newUser).set({
//     "name" :
// })
//
//   static Future<void> createUser(FirebaseUser fbuser) async {
//     bool alreadyInDB = await doesUserExist(fbuser);
//     if (!alreadyInDB) {
//       DatabaseReference ref = FirebaseDatabase.instance.reference();
//
//       var user = <String, dynamic>{
//         'name' : fbuser.displayName,
//         'email' : fbuser.email,
//         'password' : fbuser.password
//       };
//
//       ref.child("users").child(fbuser.uid).set(user);
//     } else {
//       print(fbuser.displayName + " already exists in Realtime Database");
//     }
//   }
//
//   static Future<bool> doesUserExist(FirebaseUser fbuser) async {
//     DatabaseReference ref = FirebaseDatabase.instance.reference();
//     String name = await ref.child('users').child(fbuser.uid).once().then((DataSnapshot snap) {
//       return snap.value["name"];
//     });
//
//     if (name == fbuser.displayName)
//       return true;
//     else
//       return false;
//   }
// }