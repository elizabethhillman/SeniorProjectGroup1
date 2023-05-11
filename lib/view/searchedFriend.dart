
import 'package:fitlife/model/user_database.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:fitlife/model/User.dart';
import 'package:fitlife/controller/searchFriends.dart';
import 'package:fitlife/view/comment.dart';

import '../model/Post.dart';
import '../model/post_database.dart';

class SearchedFriend extends StatefulWidget {
  const SearchedFriend({Key? key}) : super(key: key);

  @override
  State<SearchedFriend> createState() => _SearchedFriend();
}

class _SearchedFriend extends State<SearchedFriend> {
  Future<List<Post>> getUserPosts() async {
    return await getUsersPosts(searchedUser.handle);
  }

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "@${searchedUser.handle}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    searchedUser.trainer=="true" ? const Icon(Icons.star) : const SizedBox.shrink(),
                  ],
                ),
                CircleAvatar(
                  radius: 75,
                  backgroundImage: searchedUser.profilePic.isNotEmpty ? AssetImage(searchedUser.profilePic) : const AssetImage('lib/view/image/blankAvatar.png'),
                )
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
              const SizedBox(height: 10,),
              const Text(
                "Bio",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .95,
                child: TextField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: searchedUser.bio,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
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
                  setCurrentUser(currentUser.name, currentUser.handle, currentUser.email, currentUser.password, currentUser.bio, await getFollowers(currentUser.email), await getFollowing(currentUser.email), currentUser.trainer, currentUser.profilePic);
                  setSearchedUser(searchedUser.name, searchedUser.handle, searchedUser.email, searchedUser.password, searchedUser.bio, await getFollowers(searchedUser.email), await getFollowing(searchedUser.email), searchedUser.trainer, searchedUser.profilePic);
                  setState(() {
                  });

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
            children:  [
              const Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ),
              const SizedBox(width: 10),
              Text("${searchedUser.handle}'s Posts",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ),
            ],
          ),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FutureBuilder<List<Post>>(
                  future: getUserPosts(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Post> feedPosts = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: feedPosts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Post post = feedPosts[index];
                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('@${post.userHandle}', style: const TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image(
                                      image:
                                      AssetImage(post.imageurl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(post.caption),
                                ],
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.favorite),
                                    onPressed: () async {
                                      bool found = false;
                                      String lik = await getWhoLiked(feedPosts[index].id);
                                      List<String> all = lik.split(",");
                                      for(var x in all)
                                      {
                                        if(x.compareTo(currentUser.handle) == 0) {found = true;}
                                      }

                                      if(!found)
                                      {
                                        addLike(feedPosts[index].id);
                                        addWhoLiked(feedPosts[index].id, currentUser.handle);
                                      }
                                      else
                                      {
                                        removeLike(feedPosts[index].id);
                                        removeWhoLiked(feedPosts[index].id, currentUser.handle);
                                      }
                                      feedPosts[index].likes = await getLikes(feedPosts[index].id);
                                      // String vals = await getWhoLiked(feedPosts[index].id);
                                      // List<String>
                                      setState(() {
                                        setCurrentPost(feedPosts[index].id,feedPosts[index].userHandle, feedPosts[index].imageurl, feedPosts[index].caption, feedPosts[index].comments, feedPosts[index].likes, feedPosts[index].whoLiked, feedPosts[index].userTrainer);
                                      });
                                    },
                                    // color: feedPosts[index].hasBeenLiked ? Colors.red : Colors.grey,
                                  ),
                                  Text('${feedPosts[index].likes}'),
                                  IconButton(
                                    onPressed: () {
                                      setSearchedPost(feedPosts[index].id, feedPosts[index].userHandle, feedPosts[index].imageurl, feedPosts[index].caption, feedPosts[index].comments, feedPosts[index].likes, feedPosts[index].whoLiked, feedPosts[index].userTrainer);
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => const Comment()));},
                                    icon: const Icon(Icons.comment),
                                  ),
                                  Text('${feedPosts[index].comments.isEmpty ? 0 : feedPosts[index].comments.split(",").length}'),
                                ],
                              ),

                            );

                          },
                        );
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          )
          )],
      ),
    );
  }
}