import 'package:fitlife/model/user_database.dart';
import 'Post.dart';
import 'User.dart';

void addPost(String handle, String image, String caption) async {
    Database db = Database();
    var conn = await db.getSettings();
    await conn.query("INSERT INTO `fitlife`.`posts` (`handle`, `imageURL`, `caption`, `likes`, `whoLiked`, `comments`) VALUES ('$handle', '$image', '$caption', 0, '', '');");
    var id = await conn.query("SELECT MAX(id) from fitlife.user;");
    var result = await conn.query('SELECT id FROM fitlife.user;');
    for(var res in result)
    {
      currentPost.id = res['MAX(id)'];
    }
    await conn.close();
}

void deletePost(int postId) async
{
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("DELETE FROM `fitlife`.`posts` WHERE (`id` = '$postId');");
  await conn.close();
}

Future<int> getLikes(int postId) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.posts");
  var result = await conn.query('SELECT id, likes FROM fitlife.posts;');
  for(var res in result)
  {
    if(postId==res['id'])
    {
      return res['likes'];
    }
  }

  await conn.close();

  return -1;
}

Future<String> getComments(int postId) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.posts");
  var result = await conn.query('SELECT id, comments FROM fitlife.posts;');
  for(var res in result)
  {
    if(postId==res['id'])
    {
      return res['comments'];
    }
  }

  await conn.close();

  return "";
}

Future<String> getImage(int postId) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.posts");
  var result = await conn.query('SELECT id, imageURL FROM fitlife.posts;');
  for(var res in result)
  {
    if(postId==res['id'])
    {
      return res['imageURL'];
    }
  }

  await conn.close();

  return "";
}

Future<int> getPostID(String handle, String image) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.posts");
  var result = await conn.query('SELECT id, handle, imageURL FROM fitlife.posts;');
  for(var res in result)
  {
    if(handle.compareTo(res['handle'])==0 && image.compareTo(res['imageURL'])==0)
    {
      return res['id'];
    }
  }

  await conn.close();

  return -1;
}

Future<String> getWhoLiked(int postId) async{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.posts");
  var result = await conn.query('SELECT id, whoLiked FROM fitlife.posts;');
  for(var res in result)
  {
    if(postId==res['id'])
    {
      return res['whoLiked'];
    }
  }

  await conn.close();

  return "";
}

void addLike(int postId) async
{
  Database db = Database();
  var conn = await db.getSettings();
  int currentLikes = await getLikes(postId);
  int newLikes = currentLikes + 1;
  await conn.query("UPDATE `fitlife`.`posts` SET `likes` = '$newLikes' WHERE (`id` = '$postId');");
  await conn.close();
}

void addWhoLiked(int postId, String likerHandle) async {
  String likers = await getWhoLiked(postId);
  Database db = Database();
  var conn = await db.getSettings();
  List<String> all = likers.split(",");
  if (!all.contains(likerHandle)) {
    if (likers.isNotEmpty) {
      await conn.query(
          "UPDATE `fitlife`.`posts` SET `whoLiked` = '$likers, $likerHandle' WHERE (`id` = '$postId');");
    }
    else {
      await conn.query(
          "UPDATE `fitlife`.`posts` SET `whoLiked` = '$likerHandle' WHERE (`id` = '$postId');");
    }
  }
}

void removeWhoLiked(int postId, String unLikerHandle) async
{
  String likers = await getWhoLiked(postId);
  Database db = Database();
  var conn = await db.getSettings();
  List<String> all = likers.split(",");
  for(int i = 0; i < all.length; i++) {
    all[i] = all[i].replaceAll(" ", '');
  }
  if(all.contains(unLikerHandle)) {
    if(all.length>1)
    {
      await conn.query(
          "UPDATE `fitlife`.`posts` SET `whoLiked` = REPLACE('$likers', ', $unLikerHandle', '') WHERE (`id` = '$postId');");
    }
    else {
      await conn.query(
          "UPDATE `fitlife`.`posts` SET `whoLiked` = REPLACE('$likers', '$unLikerHandle', '') WHERE (`id` = '$postId');");
    }}
  await conn.close();
}

void removeLike(int postId) async
{
  Database db = Database();
  var conn = await db.getSettings();
  int currentLikes = await getLikes(postId);
  int newLikes = currentLikes - 1;
  await conn.query("UPDATE `fitlife`.`posts` SET `likes` = '$newLikes' WHERE (`id` = '$postId');");
  await conn.close();
}

void addComment(int postId, String newComment, String userHandle) async
{
  Database db = Database();
  var conn = await db.getSettings();
  String comments = await getComments(postId);
  if(comments.isEmpty)
  {
    await conn.query("UPDATE `fitlife`.`posts` SET `comments` = '$userHandle: $newComment' WHERE (`id` = '$postId');");
  }
  else
  {
    await conn.query("UPDATE `fitlife`.`posts` SET `comments` = '$comments,$userHandle: $newComment' WHERE (`id` = '$postId');");
  }
  await conn.close();
}

void removeComment(int postId, String commentToReplace) async
{
  Database db = Database();
  var conn = await db.getSettings();
  String comments = await getComments(postId);
  List<String> allComments = comments.split(",");
  if(allComments.length == 1)
  {
    await conn.query("UPDATE `fitlife`.`posts` SET `comments` = '' WHERE (`id` = '$postId');");
  }
  else
  {
    await conn.query("UPDATE `fitlife`.`posts` SET `comments` = REPLACE('$comments', ',$commentToReplace', '') WHERE (`id` = '$postId');");  }
  await conn.close();
}


void updateCaption(int postID, String newCaption) async
{
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("UPDATE `fitlife`.`posts` SET `caption` = '$newCaption' WHERE (`id` = '$postID');");
  await conn.close();
}

Future<List<Post>> getUsersPosts(String handle) async
{
  Database db = Database();
  var conn = await db.getSettings();
  List<Post> usersPosts= [];
  var id = await conn.query("SELECT * from fitlife.posts");
  var result = await conn.query('SELECT id, handle, imageURL, caption, likes, whoLiked, comments, userTrainer FROM fitlife.posts;');
  for(var res in result)
  {
    if(handle.compareTo(res['handle'])==0)
    {
      Post post = Post(id: res['id'], userHandle: handle, imageurl: res['imageURL'], caption: res['caption'], likes: res['likes'], whoLiked: res['whoLiked'], comments: res['comments'], userTrainer: res['userTrainer']);
      usersPosts.add(post);
    }
  }
  await conn.close();

  return usersPosts;
}

Future<List<Post>> populateFeed(User user) async
{
  Database db = Database();
  var conn = await db.getSettings();
  List<Post> allPosts= [];
  var id = await conn.query("SELECT * from fitlife.posts");
  var result = await conn.query('SELECT *  FROM fitlife.posts;');
  String userFollowing = await getFollowing(user.email);
  List<String> userFollowingList = userFollowing.split(",");
  for(var res in result)
  {
    if(user.handle.compareTo(res['handle'])==0 || userFollowingList.contains(res['handle']))
    {
        Post post = Post(id: res['id'],
          userHandle: res['handle'],
            imageurl: res['imageURL'],
            caption: res['caption'],
            likes: res['likes'],
            whoLiked: res['whoLiked'],
            comments: res['comments'],
        userTrainer: res['userTrainer']);
        allPosts.add(post);
    }
  }
  await conn.close();

  return allPosts;
}

void updateUserTrainer(String val) async
{
  Database db = Database();
  var conn = await db.getSettings();
  await conn.query("UPDATE `fitlife`.`posts` SET `userTrainer` = '$val' WHERE (`handle` = '${currentUser.handle}');");
  await conn.close();
}


