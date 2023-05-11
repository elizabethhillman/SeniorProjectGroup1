
import 'package:fitlife/controller/updateCaption.dart';
import 'package:fitlife/model/user_database.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:fitlife/controller/searchFriends.dart';
import 'package:fitlife/controller/searchTrainers.dart';
import 'package:fitlife/model/User.dart';
import 'package:fitlife/model/Post.dart';
import 'package:fitlife/view/comment.dart';
import '../model/post_database.dart';
import 'commentFromSocial.dart';
import '../controller/createPost.dart';


class SocialMedia extends StatefulWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  Future<List<Post>> getUserPosts() async {
    return await getUsersPosts(currentUser.handle);
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
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
                      children: [Text(
                        "@${currentUser.handle}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                        currentUser.trainer=="true" ? const Icon(Icons.star) : const SizedBox.shrink(),
                      ]
                    ),
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: currentUser.profilePic.isNotEmpty ? AssetImage(currentUser.profilePic) : const AssetImage('lib/view/image/blankAvatar.png'),
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
                    "${currentUserFollowersCount()}",
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
                    "${currentUserFollowingCount()}",
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ])]),
              Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              // const Text(
              //   "Bio",
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 15,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .95,
                child: TextField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: currentUser.bio,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreatePost()),
                  );
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                child: const Text('Make a Post'),
              ),

              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchFriends()));
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
                child: const Text('Find Friends'),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchTrainers()));
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
                child: const Text('Find Trainers'),
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
                'Your Photos',
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
                                      AssetImage(feedPosts[index].imageurl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(post.caption),
                                ],
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  const Icon(Icons.favorite,),
                                  Text('${post.likes}'),
                                  IconButton(
                                    onPressed: () {
                                        setSearchedPost(post.id, post.userHandle, post.imageurl, post.caption, post.comments, post.likes, post.whoLiked, post.userTrainer);
                                        Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const CommentFromSocial()));},

                                    icon: const Icon(Icons.comment,),
                                  ),
                                  Text('${post.comments.isEmpty ? 0 : post.comments.split(",").length}'),
                                  const SizedBox(width: 160,),
                                  IconButton(onPressed: (){
                                    setSearchedPost(post.id, post.userHandle, post.imageurl, post.caption, post.caption, post.likes, post.whoLiked, post.userTrainer);
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const UpdateCaption()));
                                  }, icon: const Icon(Icons.edit, color: Colors.blue,)),
                                IconButton(
                                  icon: const Icon(Icons.delete_forever, color: Colors.red,),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Delete Post'),
                                          content: const Text('Are you sure you want to delete this post?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Delete'),
                                              onPressed: () {
                                                deletePost(post.id);
                                                setState(() {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
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
