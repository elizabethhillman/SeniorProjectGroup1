import 'package:fitlife/model/User.dart';
import 'package:fitlife/model/post_database.dart';
import 'package:fitlife/model/user_database.dart';
import 'package:fitlife/view/comment.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:flutter/material.dart';

import '../model/Post.dart';
import 'account.dart';
import 'calorie.dart';
import 'homePage.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Future<List<Post>> generateFeed() async {
    return await populateFeed(currentUser);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          // title: Text(widget.title),
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
            "Feed",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.fitness_center),
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyWorkouts()));
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SocialMedia()));
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<List<Post>>(
                future: generateFeed(),
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
                          // setCurrentPost(feedPosts[index].id,feedPosts[index].userHandle, feedPosts[index].imageurl, feedPosts[index].caption, feedPosts[index].comments, feedPosts[index].likes, feedPosts[index].whoLiked);
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      '@${feedPosts[index].userHandle}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    feedPosts[index].userTrainer == "true"
                                        ? Icon(
                                            Icons.star,
                                            size: 20,
                                            color: Colors.amber,
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image(
                                    image:
                                        AssetImage(feedPosts[index].imageurl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(feedPosts[index].caption),
                              ],
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.favorite),
                                  onPressed: () async {
                                    bool found = false;
                                    String lik =
                                        await getWhoLiked(feedPosts[index].id);
                                    List<String> all = lik.split(",");
                                    for (var x in all) {
                                      if (x.compareTo(currentUser.handle) ==
                                          0) {
                                        found = true;
                                      }
                                    }

                                    if (!found) {
                                      addLike(feedPosts[index].id);
                                      addWhoLiked(feedPosts[index].id,
                                          currentUser.handle);
                                    } else {
                                      removeLike(feedPosts[index].id);
                                      removeWhoLiked(feedPosts[index].id,
                                          currentUser.handle);
                                    }
                                    feedPosts[index].likes =
                                        await getLikes(feedPosts[index].id);
                                    // String vals = await getWhoLiked(feedPosts[index].id);
                                    // List<String>
                                    setState(() {
                                      setCurrentPost(
                                          feedPosts[index].id,
                                          feedPosts[index].userHandle,
                                          feedPosts[index].imageurl,
                                          feedPosts[index].caption,
                                          feedPosts[index].comments,
                                          feedPosts[index].likes,
                                          feedPosts[index].whoLiked,
                                          feedPosts[index].userTrainer);
                                    });
                                  },
                                  // color: feedPosts[index].hasBeenLiked ? Colors.red : Colors.grey,
                                ),
                                Text('${feedPosts[index].likes}'),
                                IconButton(
                                  onPressed: () {
                                    setSearchedPost(
                                        feedPosts[index].id,
                                        feedPosts[index].userHandle,
                                        feedPosts[index].imageurl,
                                        feedPosts[index].caption,
                                        feedPosts[index].comments,
                                        feedPosts[index].likes,
                                        feedPosts[index].whoLiked,
                                        feedPosts[index].userTrainer);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Comment()));
                                  },
                                  icon: const Icon(Icons.comment),
                                ),
                                Text(
                                    '${feedPosts[index].comments.isEmpty ? 0 : feedPosts[index].comments.split(",").length}'),
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
        ));
  }
}

// ListView.builder(
//   itemCount: posts.length,
//   itemBuilder: (BuildContext context, int index) {
//     final String post = posts[index];
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image placeholder
//           Container(
//             width: double.infinity,
//             height: 200,
//             color: Colors.grey[300],
//             margin: const EdgeInsets.only(bottom: 16.0),
//           ),
//           Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.favorite),
//                 onPressed: () {
//                   // add heart becomes filled? and #likes goes up
//                 },
//               ),
//               IconButton(
//                 icon: const Icon(Icons.comment),
//                 onPressed: () {
//                   // goes to a separate page with all comments shown, and area to type out a comment, and add to DB
//                 },
//               ),
//             ],
//           ),
// ],
// ),
// );
// },
// ),
// );
// Comments container
