import 'package:flutter/material.dart';

class Post {

  Post({
    required this.id,
    required this.userHandle,
    required this.imageurl,
    required this.caption,
    required this.likes,
    required this.comments
  });

  int id;
  String userHandle;
  String imageurl;
  String caption;
  int likes;
  String comments;
}

  // dk if this is needed
  //Post({this.id, this.userId, this.imageurl, this.caption});

  Post currentPost = Post(id: -1, userHandle: "", imageurl: "", caption: "", likes: 0, comments: "");
  //void setCurrentUser(String name, String handle, String email, String password, String bio, String followers, String following, String trainer)

  ///dont set id, let SQL do that
  void setCurrentPost(String handle, String imageURL, String caption)
  {
  currentPost.userHandle = handle;
  // the Ink.image part it autofilled so I am keeping here until I understand what to do.
 // currentPost.imageurl = Ink.image(image: image);
  currentPost.caption = caption;


  }



