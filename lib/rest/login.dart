import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:provider/provider.dart';

class Login with ChangeNotifier {
  String _userid;

  Map<String, String> userdat = Map<String, String>();

  String get userid {
    return _userid;
  }

  bool get isauth {
    return _userid != null;
  }

  Future<dynamic> __call_url(Map<String, String> request_data) async {
    var url = "https://b135-106-208-18-231.ngrok.io/video/login.php";

    print('test');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: request_data,
      );
      final responseData = json.decode(response.body);
      print(responseData);
      print(response.statusCode);

      return responseData;
      if (response.statusCode == 200)
        return responseData.toString();
      else
        throw (response.reasonPhrase);
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> loginuser(Map<String, String> logindat) async {
    logindat['login'] = 'check';
    try {
      final extractedData = await __call_url(logindat);
      if (extractedData == 1) {
        throw ('Email or Phone doesn\'t exists');
      } else if (extractedData == 2) {
        throw ('Wrong password');
      } else if (extractedData[0].containsKey('userID')) {
        _userid = logindat['userid'];
        extractedData[0]
            .forEach((key, value) => userdat[key] = value?.toString());
        notifyListeners();
      } else {
        throw ("Something went wrong");
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<String> timeupdate(Map<String, String> auto_log_dat) async {
    auto_log_dat['auto-login-set'] = 'true';
    auto_log_dat.remove('login');
    print(auto_log_dat);
    try {
      final response_data = await __call_url(auto_log_dat);
      if (response_data == 6) {
        print('success');
        final prefs = await SharedPreferences.getInstance();
        final tokenData = json.encode({
          'userid': auto_log_dat['userid'],
          'password': auto_log_dat['password'],
        });
        prefs.setString('tokenData', tokenData);
        return "Credentials Saved Successfully";
      } else {
        return "There's problem saving Data!";
      }
    } catch (e) {
      return e;
    }
  }

  Future<bool> checkuser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('tokenData')) {
      print('token data');
      final TokenData =
          json.decode(prefs.getString('tokenData')) as Map<String, Object>;

      final extractedDataTokenData =
          TokenData.map((key, value) => MapEntry(key, value?.toString()));

      extractedDataTokenData['auto-login-check'] = 'true';
      print(extractedDataTokenData);
      final extractedData = await __call_url(extractedDataTokenData);

      if (extractedData == 5) {
        print('Auto login not enabled for this user');
        return false;
      } else if (extractedData[0].containsKey('userID')) {
        print('Auto login successfull');

        extractedData[0]
            .forEach((key, value) => userdat[key] = value?.toString());
        _userid = userdat['userID'];
        print(userdat);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
    print('No Token found');
    return false;
  }

  Future<String> logout(String id) async {
    final request_data = {'userid': id, 'logout': 'true'};
    print(request_data);
    try {
      final response = await __call_url(request_data);
      if (response == 8) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('tokenData');
        _userid = null;
        notifyListeners();
        return response.toString();
      } else {
        return response.toString();
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<void> editDetails(String type, Map<String, String> details) async {
    String id = details['userid'];
    details.remove('userid');
    details.remove('password');
    print(details);

    var url =
        "https://emergency-call-app-275218-default-rtdb.firebaseio.com/authetication/$type/$id.json";
    try {
      final response = await http.patch(url, body: json.encode(details));
      final prefs = await SharedPreferences.getInstance();
      final tokenData = json.encode({
        'type': type,
        'userid': id,
        'password': details['cfnpass'],
      });
      prefs.setString('tokenData', tokenData);
      _userid = id;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
