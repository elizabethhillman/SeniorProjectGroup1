import 'package:flutter/material.dart';

class Post {

  Post({
    required this.id,
    required this.userId,
    required this.imageurl,
    required this.caption
  });

  int id;
  int userId;
  String imageurl;
  String caption;
}

  // dk if this is needed
  //Post({this.id, this.userId, this.imageurl, this.caption});

  Post currentPost = Post(id: -1, userId: -1, imageurl: "", caption: "");
  //void setCurrentUser(String name, String handle, String email, String password, String bio, String followers, String following, String trainer)

  ///dont set id, let SQL do that
  void setCurrentPost(int userID, String imageURL, String caption)
  {
  currentPost.userId = userID;
  // the Ink.image part it autofilled so I am keeping here until I understand what to do.
 // currentPost.imageurl = Ink.image(image: image);
  currentPost.caption = caption;


  }



