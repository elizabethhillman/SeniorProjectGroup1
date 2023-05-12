import 'package:fitlife/model/Post.dart';
import 'package:fitlife/model/User.dart';
import 'package:fitlife/model/post_database.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:flutter/material.dart';
import '../view/Feed.dart';


class CommentFromSocial extends StatefulWidget {
  const CommentFromSocial({Key? key}) : super(key: key);

  @override
  State<CommentFromSocial> createState() => _CommentFromSocial();
}

class _CommentFromSocial extends State<CommentFromSocial> {
  final TextEditingController commentController = TextEditingController();

  Future<String> allComments() async {
    return await getComments(searchedPost.id);
  }

  @override
  void initState() {
    super.initState();
    commentController.addListener(() {
      // setState(() {
      //   _showClearIcon = _searchController.text.isNotEmpty;
      // });
    });
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
            // Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const SocialMedia()));
          },
        ),
        title: const Text(
          "Comments",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          // const Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image(
              image:
              AssetImage(searchedPost.imageurl),
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('@${searchedPost.userHandle}:', style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14),),
              const SizedBox(width: 5,),
              Text(searchedPost.caption, style: const TextStyle(fontSize: 14),),
            ],
          ),
          Expanded(child: FutureBuilder<String>(
            future: allComments(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  String comments = snapshot.data!;
                  List<String> everyComment = comments.split(",");
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: everyComment.length,
                      itemBuilder: (BuildContext context, int index) {
                        // setCurrentPost(feedPosts[index].id,feedPosts[index].userHandle, feedPosts[index].imageurl, feedPosts[index].caption, feedPosts[index].comments, feedPosts[index].likes, feedPosts[index].whoLiked);
                        return ListTile(
                            title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  everyComment[index].isEmpty ||
                                      currentUser.handle.compareTo(
                                          everyComment[index]
                                              .substring(0,
                                              everyComment[index].indexOf(":"))
                                              .replaceAll(" ", '')) != 0
                                      ? const SizedBox(width: 46,)
                                      : IconButton(
                                    icon: const Icon(Icons.delete_forever),
                                    onPressed: () async {
                                      removeComment(
                                          searchedPost.id, everyComment[index]);
                                      setState(() {});
                                    },),
                                  RichText(
                                    text: TextSpan(
                                      style:
                                      const TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: everyComment[index]
                                              .substring(0,
                                              everyComment[index].indexOf(":") +
                                                  1)
                                              .replaceAll(" ", '')
                                              .isEmpty
                                              ? ''
                                              : '@${everyComment[index]
                                              .substring(0,
                                              everyComment[index].indexOf(":") +
                                                  1)
                                              .replaceAll(" ", '')}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text: everyComment[index].substring(
                                                everyComment[index].indexOf(
                                                    ":") + 1)),
                                      ],
                                    ),
                                  )
                                ])
                        );
                      });
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      controller: commentController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add your comment...',
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: () {
                  addComment(searchedPost.id, commentController.text,
                      currentUser.handle);
                  commentController.clear();
                  setState(() {});
                },
                  icon: const Icon(
                    Icons.check_circle, color: Colors.green, size: 40,),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}