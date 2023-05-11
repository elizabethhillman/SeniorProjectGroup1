import 'package:fitlife/model/userWeight.dart';
import 'package:flutter/material.dart';

class Post {

  Post({
    required this.id,
    required this.userHandle,
    required this.imageurl,
    required this.caption,
    required this.likes,
    required this.whoLiked,
    required this.comments,
    required this.userTrainer,
  });

  int id;
  String userHandle;
  String imageurl;
  String caption;
  int likes;
  String whoLiked;
  String comments;
  String userTrainer;
}

  // dk if this is needed
  //Post({this.id, this.userId, this.imageurl, this.caption});

  Post currentPost = Post(id: -1, userHandle: "", imageurl: "", caption: "", likes: 0, whoLiked: "", comments: "", userTrainer: "");
  Post searchedPost = Post(id: -1, userHandle: "", imageurl: "", caption: "", likes: 0, whoLiked: "", comments: "", userTrainer: "");

  //void setCurrentUser(String name, String handle, String email, String password, String bio, String followers, String following, String trainer)

  ///dont set id, let SQL do that
  void setCurrentPost(int id, String handle, String imageURL, String caption, String comments, int likes, String whoLiked, String userTrainer)
  {
    currentPost.id = id;
  currentPost.userHandle = handle;
  currentPost.imageurl = imageURL;
  currentPost.comments = comments;
  currentPost.caption = caption;
  currentPost.likes = likes;
  currentPost.whoLiked = whoLiked;
  currentPost.userTrainer = userTrainer;
  }

void setSearchedPost(int id, String handle, String imageURL, String caption, String comments, int likes, String whoLiked, String userTrainer)
{
  searchedPost.id = id;
  searchedPost.userHandle = handle;
  searchedPost.imageurl = imageURL;
  searchedPost.comments = comments;
  searchedPost.caption = caption;
  searchedPost.likes = likes;
  searchedPost.whoLiked = whoLiked;
  searchedPost.userTrainer = userTrainer;
}

List<String> postsLikes()
{
  List<String> allLikes = currentPost.whoLiked.split(",");
  return allLikes;
}

int postsLikesCount()
{
  List<String> allLiked =  currentPost.whoLiked.split(",");
  if(allLiked.first == "0" || allLiked.first.isEmpty) return 0;
  return allLiked.length;
}



