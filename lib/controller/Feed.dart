import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<String> posts = [
    "Post 1",
    // Figure out how to take posts once created and name them + attach each name to a post?
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          final String post = posts[index];
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image placeholder
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.only(bottom: 16.0),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        // add heart becomes filled? and #likes goes up
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        // goes to a separate page with all comments shown, and area to type out a comment, and add to DB
                      },
                    ),
                  ],
                ),
                // Comments container
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: 5, // Replace with the actual number of comments
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text("Comment $index"),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
