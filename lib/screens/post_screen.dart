import 'package:flutter/material.dart';
import '../services/post_service.dart';
import '../models/post.dart';
import 'create_post_screen.dart';
import 'edit_post_screen.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = PostService.getPosts();
  }

  Future<void> _createPost() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CreatePostScreen()),
    );
    if (result == true) {
      setState(() {
        futurePosts = PostService.getPosts();
      });
    }
  }

  Future<void> _updatePost(Post post) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditPostScreen(post: post)),
    );
    if (result == true) {
      setState(() {
        futurePosts = PostService.getPosts();
      });
    }
  }

  Future<void> _deletePost(String postId) async {
    await PostService.deletePost(postId);
    setState(() {
      futurePosts = PostService.getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicaciones'),
      ),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Post post = snapshot.data![index];
                      return ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.body),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _updatePost(post),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deletePost(post.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _createPost,
                    child: Text('Crear Publicación'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text("No hay publicaciones"));
          }
        },
      ),
    );
  }
}
