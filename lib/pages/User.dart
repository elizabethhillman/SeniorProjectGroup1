
class User {


  User({
    required this.name,
    required this.email,
    required this.password,
    required this.handle,
  });

  String name;
  String email;
  String password;
  String handle;
}

User currentUser = User(name: "", handle: "", email: "", password: "");
List<User> allUsers = <User>[];
void setCurrentUser(String name, String handle, String email, String password)
{
  currentUser.email = email;
  currentUser.name = name;
  currentUser.password = password;
  currentUser.handle = handle;
}

User getCurrentUser()
{
  return currentUser;
}