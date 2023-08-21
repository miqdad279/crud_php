import 'package:flutter/material.dart';
import '../models/model.dart';
import '../viewmodels/user_vm.dart';
import 'create.dart';
import 'edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List dataPost = [];
  void getDataPost() async {
    PostViewModel().getPots().then((value) {
      setState(() {
        dataPost = value;
      });
    });
  }

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    getDataPost();
  }

// Widget personDetailCard(String name, String username, String email) {
  Widget postDetail(Post data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.judul,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                data.penulis,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  hapusPost(String id) {
    PostViewModel().deletePost(id).then((value) => getDataPost());
  }

  updatePost(Post post) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => EditPostScreen(
              post: post,
            )));
  }

  showDetailDialog(Post data) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Detail Post'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ID : ${data.id}"),
                    Text("Judul : ${data.judul}"),
                    Text("Penulis : ${data.penulis}"),
                    Text("Review : ${data.review}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              hapusPost(data.id);
                              Navigator.of(context).pop();
                            },
                            child: const Text("Hapus")),
                        ElevatedButton(
                            onPressed: () {
                              updatePost(data);
                            },
                            child: const Text("Edit"))
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Utama"),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, i) {
            return GestureDetector(
                onTap: () {
                  showDetailDialog(dataPost[i]);
                },
                child: postDetail(dataPost[i]));
          },
// ignore: unnecessary_null_comparison
          itemCount: dataPost == null ? 0 : dataPost.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreatePostScreen()))
        },
        heroTag: 'createNew',
        backgroundColor: const Color(0xFF242569),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
