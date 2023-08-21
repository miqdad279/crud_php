import 'package:flutter/material.dart';
import '../models/model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../viewmodels/user_vm.dart';
import 'home.dart';

// ignore: must_be_immutable
class EditPostScreen extends StatefulWidget {
  const EditPostScreen({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
// ignore: no_logic_in_create_state
  State<EditPostScreen> createState() => _EditPostScreenState(post);
}

class _EditPostScreenState extends State<EditPostScreen> {
  Post? post;
  _EditPostScreenState(this.post);
  late final TextEditingController _textIDController = TextEditingController();
  late final TextEditingController _textJudulController =
      TextEditingController();
  late final TextEditingController _textPenulisController =
      TextEditingController();
  late final TextEditingController _textReviewController =
      TextEditingController();

  late String penulis = "", review = "", judul = "";
  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _textIDController.text = post!.id;
    _textJudulController.text = post!.judul;
    _textPenulisController.text = post!.penulis;
    _textReviewController.text = post!.review;
    judul = post!.judul;
    penulis = post!.penulis;

    review = post!.review;
  }

  updatePost() async {
    if ((penulis == "") || (review == "") || (judul == "")) {
      Fluttertoast.showToast(
          msg: "Semua Field harus diisi!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    } else {
      showLoaderDialog(context);
      PostViewModel().editPost(post!.id, judul, penulis, review).then((value) {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
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
      appBar: AppBar(title: const Text("Edit Post")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("ID"),
            SizedBox(
              height: 25,
              child: TextField(
                controller: _textIDController,
                enabled: false,
                onChanged: (e) => judul = e,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Judul Buku"),
            SizedBox(
              height: 25,
              child: TextField(
                controller: _textJudulController,
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
                controller: _textPenulisController,
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
                controller: _textReviewController,
                onChanged: (e) => review = e,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      updatePost();
                    },
                    child: const Text("Update")))
          ],
        ),
      ),
    );
  }
}
