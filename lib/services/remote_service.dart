import 'package:untitled1/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService
{
  Future<List<Post>?> getPosts() async {
      var client = http.Client();

      var uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
      var respose = await client.get(uri);
      if (respose.statusCode == 200) {
       var json = respose.body;
       return postFromJson(json);
      }
  }
}