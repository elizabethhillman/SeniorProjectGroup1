import 'package:fitlife/model/Post.dart';
import 'package:fitlife/model/User.dart';
import 'package:fitlife/model/post_database.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:flutter/material.dart';

class UpdateCaption extends StatefulWidget {
  const UpdateCaption({Key? key}) : super(key: key);

  @override
  State<UpdateCaption> createState() => _UpdateCaption();
}

class _UpdateCaption extends State<UpdateCaption> {
  final TextEditingController captionController =
      TextEditingController(text: searchedPost.caption);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SocialMedia()));
            },
          ),
          title: const Text(
            "Edit Caption",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        body: Column(
          children: <Widget>[
            // const Padding(padding: EdgeInsets.all(10)),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                searchedPost.imageurl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * .90,
              child: TextField(
                controller: captionController,
                // decoration: InputDecoration(
                //   border: OutlineInputBorder(),
                // ),
              ),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
                onPressed: () {
                  updateCaption(searchedPost.id, captionController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SocialMedia()));
                },
                child: const Text("Save")),
            // const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SocialMedia()));
                },
                child: const Text("Cancel"))
          ],
        ));
  }
}
