
class User {


  User({
    required this.name,
    required this.email,
    required this.password,
    required this.handle,
    required this.id,
  });

  String name;
  String email;
  String password;
  String handle;
  int id;
}

User currentUser = User(id: -1, name: "", handle: "", email: "", password: "");
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

void setId(var num)
{
  currentUser.id = num;
}