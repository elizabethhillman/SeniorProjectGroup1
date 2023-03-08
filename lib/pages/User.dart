
class User {


  User({
    required this.name,
    required this.email,
    required this.password,
  });

  String name;
  String email;
  String password;
}

User currentUser = User(name: "", email: "", password: "");
List<User> allUsers = <User>[];
void setCurrentUser(String name, String email, String password)
{
  currentUser.email = email;
  currentUser.name = name;
  currentUser.password = password;
}

User getCurrentUser()
{
  return currentUser;
}