
class User {


  User({
    required this.name,
    required this.email,
    required this.password,
    required this.handle,
    required this.id,
    required this.bio,
    required this.following,
    required this.followers
  });

  String name;
  String email;
  String password;
  String handle;
  int id;
  String bio;
  String followers;
  String following;
}

User currentUser = User(id: -1, name: "", handle: "", email: "", password: "", bio: "", followers: "-1", following: "-1");
User searchedUser = User(id: -1, name: "", handle: "", email: "", password: "", bio: "", followers: "-1", following: "-1");
List<User> allUsers = <User>[];
void setCurrentUser(String name, String handle, String email, String password, String bio, String followers, String following)
{
  currentUser.email = email;
  currentUser.name = name;
  currentUser.password = password;
  currentUser.handle = handle;
  currentUser.followers = followers;
  currentUser.following = following;
  currentUser.bio = bio;
}

List<String> currentUserFollowers()
{
  List<String> allFollowers = currentUser.followers.split(",");
  return allFollowers;
}

int currentUserFollowersCount()
{
  List<String> allFollowers = currentUser.followers.split(",");
  if(allFollowers.first == "0" || allFollowers.first.isEmpty) return 0;
  return allFollowers.length;
}

List<String> currentUserFollowing()
{
  List<String> allFollowers = currentUser.following.split(",");
  return allFollowers;
}

int currentUserFollowingCount()
{
  List<String> allFollowers = currentUser.following.split(",");
  if(allFollowers.first == "0" || allFollowers.first.isEmpty) return 0;
  return allFollowers.length;
}

User getCurrentUser()
{
  return currentUser;
}

void setSearchedUser(String name, String handle, String email, String password, String bio, String followers, String following)
{
  searchedUser.email = email;
  searchedUser.name = name;
  searchedUser.password = password;
  searchedUser.handle = handle;
  searchedUser.followers = followers;
  searchedUser.following = following;
  searchedUser.bio = bio;
}

List<String> searchedUserFollowers()
{
  List<String> allFollowers = searchedUser.followers.split(",");
  return allFollowers;
}

int searchedUserFollowersCount()
{
  List<String> allFollowers = searchedUser.followers.split(",");
  if(allFollowers.first.isEmpty) return 0;
  return allFollowers.length;
}

List<String> searchedUserFollowing()
{
  List<String> allFollowers = searchedUser.following.split(",");
  return allFollowers;
}

int searchedUserFollowingCount()
{
  List<String> allFollowers = searchedUser.following.split(",");
  if(allFollowers.first.isEmpty) return 0;
  return allFollowers.length;
}

User getSearchedUser()
{
  return searchedUser;
}

void setId(int num)
{
  currentUser.id = num;
}
