import 'dart:convert';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/model.dart';
import '../viewmodels/user_vm.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late String judul = "", penulis = "", review = "";
  register() async {
    if ((judul == "") || (penulis == "") || (review == "")) {
      Fluttertoast.showToast(
          msg: "Semua Field harus diisi!",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    } else {
      showLoaderDialog(context);
      PostViewModel().createPost(judul, penulis, review).then((value) {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      });
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buat Postingan")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Judul Buku"),
            SizedBox(
              height: 25,
              child: TextField(
                onChanged: (e) => judul = e,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Penulis Buku"),
            SizedBox(
              height: 25,
              child: TextField(
                onChanged: (e) => penulis = e,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Review Buku"),
            SizedBox(
              height: 25,
              child: TextField(
                onChanged: (e) => review = e,
                textInputAction: TextInputAction.newline,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    child: const Text("Simpan")))
          ],
        ),
      ),
    );
  }
}
