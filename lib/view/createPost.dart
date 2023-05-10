import 'package:fitlife/view/workouts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'account.dart';
import 'calorie.dart';
import 'homePage.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController captionController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  @override
  void dispose() {
    captionController.dispose();
    linkController.dispose();
    super.dispose();
  }

  void createPost() async {
    String caption = captionController.text;
    String link = linkController.text;

    Uri url = Uri.parse('ADD URL HERE');
    final response = await http.post(url, body: {
      'caption': caption,
      'link': link,
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      print('Error creating post: ${response.body}');
    }
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          title: const Text(
            "Create Post",
            style: TextStyle(fontSize: 23, color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.red,
              onPressed: () {
              },
            ),
            IconButton(
              icon: const Icon(Icons.comment),
              color: Colors.grey,
              onPressed: () {
              },
            ),
            IconButton(
              icon: const Icon(Icons.fitness_center),
              color: Colors.black,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyWorkouts()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.restaurant),
              color: Colors.black,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Calorie()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              color: Colors.black,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Accounts()));
              },
            ),
          ],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: captionController,
                      decoration: const InputDecoration(
                        labelText: 'Caption',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: linkController,
                      decoration: const InputDecoration(
                        labelText
                            : 'Link',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: createPost,
                      child: const Text('Post'),
                    ),
                  ],
                ),
              ),
            ]));
  }
}
