import 'package:fitlife/model/user_database.dart';
import 'Post.dart';
import 'User.dart';

void addPost(String handle, String image, String caption) async {
    Database db = Database();
    var conn = await db.getSettings();
    await conn.query("INSERT INTO `fitlife`.`posts` (`handle`, `imageURL`, `caption`) VALUES ('$handle', '$image', '$caption');");
    var id = await conn.query("SELECT MAX(id) from fitlife.user;");
    var result = await conn.query('SELECT id FROM fitlife.user;');
    for(var res in result)
    {
      currentPost.id = res['MAX(id)'];
    }
    await conn.close();
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

void removeLike(int postId) async
{
  Database db = Database();
  var conn = await db.getSettings();
  int currentLikes = await getLikes(postId);
  int newLikes = currentLikes--;
  await conn.query("UPDATE `fitlife`.`posts` SET `likes` = '$newLikes' WHERE (`id` = '$postId');");
  await conn.close();
}

void addComment(int postId, String newComment) async
{
  Database db = Database();
  var conn = await db.getSettings();
  String comments = await getComments(postId);
  if(comments.isEmpty)
  {
    await conn.query("UPDATE `fitlife`.`posts` SET `comments` = '$newComment' WHERE (`id` = '$postId');");
  }
  else
  {
    await conn.query("UPDATE `fitlife`.`posts` SET `comments` = '$comments,$newComment' WHERE (`id` = '$postId');");
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
    await conn.query("UPDATE `fitlife`.`posts` SET `comments` = REPLACE('$comments', '$commentToReplace', '') WHERE (`id` = '$postId');");  }
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
  var result = await conn.query('SELECT handle, imageURL, caption, likes, comments FROM fitlife.posts;');
  for(var res in result)
  {
    if(handle.compareTo(res['handle'])==0)
    {
      Post post = Post(id: await getPostID(handle, res['imageURL']), userHandle: handle, imageurl: res['imageURL'], caption: res['caption'], likes: res['likes'], comments: res['comments']);
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
  var result = await conn.query('SELECT handle, imageURL, caption, likes, comments FROM fitlife.posts;');
  String userFollowing = await getFollowing(user.email);
  List<String> userFollowingList = userFollowing.split(",");
  for(var res in result)
  {
    if(user.handle.compareTo(res['handle'])==0 || userFollowingList.contains(res['handle']))
    {
        Post post = Post(id: await getPostID(res['handle'], res['imageURL']),
      // Post post = Post(id: -1,
          userHandle: res['handle'],
            imageurl: res['imageURL'],
            caption: res['caption'],
            likes: res['likes'],
            comments: res['comments']);
        allPosts.add(post);
    }
  }
  await conn.close();

  return allPosts;
}

Future<int> getLikes(int postId) async
{
  Database db = Database();
  var conn = await db.getSettings();
  var id = await conn.query("SELECT * from fitlife.posts");
  var result = await conn.query('SELECT id, likes FROM fitlife.posts;');
  for(var res in result)
  {
    if(id==res['id'])
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
    if(id==res['id'])
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
    if(id==res['id'])
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
