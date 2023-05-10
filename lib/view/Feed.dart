import 'package:fitlife/model/User.dart';
import 'package:fitlife/model/post_database.dart';
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
  void initState()  {
    super.initState();
  }

  // List<String> posts = [
  //   "Post 1",
  //   // Figure out how to take posts once created and name them + attach each name to a post?
  // ];

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
                          bool hasLiked = false;
                          final Post post = feedPosts[index];
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('@${post.userHandle}', style: const TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    post.imageurl,
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
                                    if(hasLiked == false)
                                    {
                                      addLike(post.id);
                                      hasLiked = true;
                                    }
                                    else
                                    {
                                      removeLike(post.id);
                                      hasLiked = false;
                                      print("no");
                                    }
                                    // setState(() {hasLiked = !hasLiked;});
                                    post.likes = await getLikes(post.id);
                                    setState(() {
                                      post.likes;
                                    });
                                  },
                                  color: hasLiked ? Colors.red : Colors.grey,
                                  // color: hasLiked ? Colors.red : Colors.grey,
                                ),
                                Text('${post.likes}'),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.comment),
                                ),
                                Text(post.comments),
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


}}

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
