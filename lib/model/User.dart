
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
  int followers;
  int following;
}

User currentUser = User(id: -1, name: "", handle: "", email: "", password: "", bio: "", followers: -1, following: -1);
List<User> allUsers = <User>[];
void setCurrentUser(String name, String handle, String email, String password, String bio, int followers, int following)
{
  currentUser.email = email;
  currentUser.name = name;
  currentUser.password = password;
  currentUser.handle = handle;
  currentUser.followers = followers;
  currentUser.following = following;
  currentUser.bio = bio;
}

User getCurrentUser()
{
  return currentUser;
}

void setId(int num)
{
  currentUser.id = num;
}
