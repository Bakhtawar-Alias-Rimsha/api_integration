import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../models/random_user.dart';

class ApiClient {
  static const _postsBase = 'https://jsonplaceholder.typicode.com';
  static const _randomUserBase = 'https://randomuser.me/api';

  // Fetch posts from JSONPlaceholder
  static Future<List<Post>> fetchPosts() async {
    final uri = Uri.parse('$_postsBase/posts');
    final res = await http.get(uri).timeout(const Duration(seconds: 12));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List<dynamic>;
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      throw HttpException('Failed to load posts (code: ${res.statusCode})');
    }
  }

  // Fetch single random user (with picture)
  static Future<RandomUser> fetchRandomUser() async {
    final uri = Uri.parse('$_randomUserBase');
    final res = await http.get(uri).timeout(const Duration(seconds: 12));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return RandomUser.fromApi(data);
    } else {
      throw HttpException('Failed to load user (code: ${res.statusCode})');
    }
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() => message;
}
