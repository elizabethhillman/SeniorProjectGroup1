import 'package:fitlife/model/user_database.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:fitlife/view/homePage.dart';

import '../model/User.dart';
import '../view/searchedFriend.dart';

class SearchTrainers extends StatefulWidget {
  const SearchTrainers({Key? key}) : super(key: key);

  @override
  State<SearchTrainers> createState() => _SearchTrainersState();
}

class _SearchTrainersState extends State<SearchTrainers> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchRes = [];
  bool _showClearIcon = false;

  List<String> userData = [];

  List<String> getUserData() {
    return userData;
  }

  void setUserData(List<String> data) {
    userData = data;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _showClearIcon = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: const Text(
          "Search",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.fitness_center),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyWorkouts()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.restaurant),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calorie()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.group),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SocialMedia()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Accounts()));
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (String input) async {
                List<String> ret = await findTrainer(input, currentUser.handle);
                if (ret.isNotEmpty) {
                  searchRes = ret;
                }
                else {
                  searchRes.clear();
                }
              },
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _showClearIcon
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    searchRes.clear();
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: searchRes.length,
                itemBuilder: (BuildContext context, int index) {
                  final String res = searchRes[index];
                  return Material(
                      color: Colors.transparent,
                      child: InkWell
                        (
                        onTap: () async {
                          List<String> info = await searchingByHandle(res);
                          setSearchedUser(
                              "",
                              info[0],
                              info[4],
                              "",
                              info[3],
                              info[1],
                              info[2],
                              info[5]);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (
                                  context) => const SearchedFriend()));
                        },
                        child: ListTile
                          (
                          title: Text("@$res"),
                        ),
                      )
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}