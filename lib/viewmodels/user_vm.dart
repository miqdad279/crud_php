import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model.dart';

class PostViewModel {
  Future getPots() async {
    try {
      http.Response hasil = await http.get(
          Uri.parse("http://192.168.1.6/user_api/list.php"),
          headers: {"Accept": "application/json"});
      if (hasil.statusCode == 200) {
// print(hasil.body);
        final data = userFromJson(hasil.body);
        return data;
      } else {
// print("error status " + hasil.statusCode.toString());
        return null;
      }
    } catch (e) {
// print("error catch $e");
      return null;
    }
  }

  Future deletePost(String id) async {
    Map data = {"id": id};
    try {
      http.Response hasil = await http.post(
          Uri.parse("http://192.168.1.6/user_api/delete.php"),
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      if (hasil.statusCode == 200) {
        return true;
      } else {
// print("error status " + hasil.statusCode.toString());
        return false;
      }
    } catch (e) {
// print("error catch $e");
      return false;
    }
  }

  Future createPost(String judul, String penulis, String review) async {
    Map data = {"judul": judul, "penulis": penulis, "review": review};
    try {
      http.Response hasil = await http.post(
          Uri.parse("http://192.168.1.6/user_api/create.php"),
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      if (hasil.statusCode == 200) {
        return true;
      } else {
// print("error status " + hasil.statusCode.toString());
        return false;
      }
    } catch (e) {
// print("error catch $e");
      return false;
    }
  }

  Future editPost(
      String id, String judul, String penulis, String review) async {
    Map data = {"id": id, "judul": judul, "penulis": penulis, "review": review};
    try {
      http.Response hasil = await http.post(
          Uri.parse("http://192.168.1.6/user_api/update.php"),
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      if (hasil.statusCode == 200) {
        return true;
      } else {
// print("error status " + hasil.statusCode.toString());
        return false;
      }
    } catch (e) {
// print("error catch $e");
      return false;
    }
  }
}
