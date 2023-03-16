import 'package:flutter/material.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:fitlife/view/homePage.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: const Text(
          "Post",
          style: TextStyle(fontSize: 23, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.fitness_center),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyWorkouts()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.restaurant),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calorie()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.group),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SocialMedia()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Accounts()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Post Content',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write something...',
                  suffixIcon: _textEditingController.text.isEmpty
                      ? null
                      : IconButton(
                    onPressed: () {
                      _textEditingController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: TextButton(
                    onPressed: () {}, //should be able have user attach an image from their files on computer
                    child: const Text(
                      'Add an Image',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: TextButton(
                    onPressed: () { //should also be able to take what was written/attached in text box, save in database, and display on social media page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SocialMedia(),
                        ),
                      );
                    },
                    child: const Text(
                      'Share',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}