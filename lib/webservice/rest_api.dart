import 'package:http/http.dart' as http;


class RestApi{
  Future getSystemsBasedOnUserId(var userId)async{
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer token here',
    });

    if (response.statusCode == 200) {

      //Album.fromJson(jsonDecode(response.body))
      return ;
    } else {

      throw Exception('Failed to load album');
    }

  }

  Future getSensorsBasedOnSystemId(var systemId)async{
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer token here',
    });

    if (response.statusCode == 200) {

      //Album.fromJson(jsonDecode(response.body))
      return ;
    } else {

      throw Exception('Failed to load album');
    }

  }
}