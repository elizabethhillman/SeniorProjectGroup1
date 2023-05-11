import 'dart:io';

import 'package:fitlife/model/User.dart';
import 'package:fitlife/model/post_database.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../model/user_database.dart';
import '../view/account.dart';
import '../view/calorie.dart';
import '../view/homePage.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController captionController = TextEditingController();
  final TextEditingController linkController = TextEditingController();



  String imagePath ="";

  Future uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath = pickedFile.path;
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    captionController.dispose();
    linkController.dispose();
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    TextButton(
                      onPressed: () {
                        setState(() {uploadImage();});


                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      child: const Text('Upload an image'),
                    ),
    imagePath.isNotEmpty ? const Icon(Icons.check_circle,color: Colors.green,) : const Icon(Icons.error, color: Colors.red,),
    ]),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: (){
                        addPost(currentUser.handle, imagePath, captionController.text, currentUser.trainer);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialMedia()));
                        },
                      child: const Text('Post'),
                    ),
                  ],
                ),
              ),
            ]));
  }
}
