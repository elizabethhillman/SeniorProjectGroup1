import 'package:fitlife/model/user_database.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:fitlife/model/User.dart';
import 'package:fitlife/controller/searchFriends.dart';

class SearchedFriend extends StatefulWidget {
  const SearchedFriend({Key? key}) : super(key: key);

  @override
  State<SearchedFriend> createState() => _SearchedFriend();
}

class _SearchedFriend extends State<SearchedFriend> {
  bool isFound()
  {
    List<String> names = currentUserFollowing();
    for(var name in names)
    {
      name = name.replaceAll(" ", '');
      if(name == searchedUser.handle) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState()  {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchFriends()));
          },
        ),
        title: const Text(
          "Social Media",
          style: TextStyle(fontSize: 23, color: Colors.black),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: [
                Text(
                  "@${searchedUser.handle}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Icon(
                  Icons.account_circle_outlined,
                  size: 100,
                  color: Colors.grey,
                ),
              ],
            ),
            Column(children: [
              const Text(
                'Followers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "${searchedUserFollowersCount()}",
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ]),
            Column(children: [
              const Text(
                'Following',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "${searchedUserFollowingCount()}",
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ])
          ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bio",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: searchedUser.bio,
                  ))
            ],
          ),

          ///add expanded for their pics?
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  if (isFound()) {
                    removeFollowing(currentUser, searchedUser.handle);
                    removeFollower(searchedUser, currentUser.handle);
                  } else {
                    addFollowing(currentUser, searchedUser.handle);
                    addFollower(searchedUser, currentUser.handle);
                  }
                  setCurrentUser(currentUser.name, currentUser.handle, currentUser.email, currentUser.password, currentUser.bio, await getFollowers(currentUser.email), await getFollowing(currentUser.email));
                  setSearchedUser(searchedUser.name, searchedUser.handle, searchedUser.email, searchedUser.password, searchedUser.bio, await getFollowers(searchedUser.email), await getFollowing(searchedUser.email));
                  setState(() {});

                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                child: Text(isFound() ? 'Remove Friend' : 'Add Friend'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Feed',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: const [
                // Add scrollable posts here
              ],
            ),
          ),
        ],
      ),
    );
  }
}
