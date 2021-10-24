import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Signup {
  Future<String> signupuser(Map<String, String> userDat) async {
    userDat.remove('password');
    userDat['signup'] = 'true';
    print(userDat);
    var url = "https://b135-106-208-18-231.ngrok.io/video/register.php";
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: userDat);
      final decodedresponse = json.decode(response.body);
      if (response.statusCode != 200) {
        throw (response.reasonPhrase);
      }
      print(decodedresponse);
      switch (decodedresponse) {
        case 1:
          throw ('User already exist\'s');
          break;
        case 2:
          return 'Successfully Registered';
          break;
        case 3:
          throw ('Database Error');
          break;
        default:
          throw ('Something went wrong');
          break;
      }
    } catch (e) {
      throw (e);
    }
  }
}
