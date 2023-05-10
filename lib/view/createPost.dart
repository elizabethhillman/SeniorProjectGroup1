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
    // Get the values from the text fields
    String caption = captionController.text;
    String link = linkController.text;

    // Make an HTTP request to your API endpoint to create a new post
    // Replace 'your-api-endpoint' with the actual URL of your API
    Uri url = Uri.parse('https://your-api-endpoint/create-post');
    final response = await http.post(url, body: {
      'caption': caption,
      'link': link,
    });

    // Check the response status
    if (response.statusCode == 200) {
      // Post created
      Navigator.pop(context);
    } else {
      // An error occurred
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: const Text(
          "Create Post",
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
            icon: const Icon(Icons.account_circle),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Accounts()));
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
                labelText: 'Link',
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
