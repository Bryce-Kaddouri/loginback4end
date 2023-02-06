import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  Future<void> loginUser(String username, String password) async {
    final response = await http.get(
      Uri.https('parseapi.back4app.com', '/login'),
      headers: {
        'X-Parse-Application-Id': 'H2IKWJa0fREs9I60bsMztESNp8PmE1a6PTZ6da3W',
        'X-Parse-REST-API-Key': 'yI0QuyFp7MzKNqvCGKLc1If0EQ77R6o5ilqu2f2F',
        'X-Parse-Revocable-Session': '1',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'username': '$username',
        'password': '$password'
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      // Login was successful, process the response as needed
      final data = json.decode(response.body);
      // ...
    } else {
      // Login was unsuccessful, handle the error
      // ...
    }
  }
}
