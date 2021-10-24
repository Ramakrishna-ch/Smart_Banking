import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class My_Services with ChangeNotifier {
  List<Map<String, String>> user_services = [];
  List<Map<String, String>> user_details = [];
  Map<String, String> loaded_id = {};

  List<Map<String, String>> get services_list {
    return [...user_services];
  }

  List<Map<String, String>> get details_list {
    return [...user_details];
  }

  Future<dynamic> __call_url(
      Map<String, String> request_data, String pathdata) async {
    var url = "https://b135-106-208-18-231.ngrok.io/video/$pathdata.php";

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
        return response.reasonPhrase;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<void> get_form_data(Map<String, String> new_data) async {
    new_data['request_form_details'] = 'true';
    print(new_data);
    try {
      final extractedData = await __call_url(new_data, 'form_request');

      if (extractedData == 0) {
        user_services.clear();
        return;
      } else if (extractedData == 2) {
        throw ('Wrong password');
      } else if (extractedData[0].containsKey('account_no')) {
        user_services.clear();
        for (int i = 0; i < extractedData.length; i++) {
          final Map<String, String> form_dat = {};
          extractedData[i]
              .forEach((key, value) => form_dat[key] = value?.toString());
          user_services.add(form_dat);
        }

        notifyListeners();

        return;
      } else {
        throw ("Something went wrong");
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> get_userdetails_data(Map<String, String> new_data) async {
    new_data['get_user_details'] = 'true';
    print(new_data);
    try {
      final extractedData = await __call_url(new_data, 'update_user_details');

      if (extractedData == 0) {
        user_details.clear();
        return;
      } else if (extractedData == 2) {
        throw ('Wrong password');
      } else if (extractedData[0].containsKey('account_no')) {
        user_details.clear();
        for (int i = 0; i < extractedData.length; i++) {
          final Map<String, String> form_dat = {};
          extractedData[i]
              .forEach((key, value) => form_dat[key] = value?.toString());
          user_details.add(form_dat);
        }
        print(user_details);
        notifyListeners();

        return;
      } else {
        throw ("Something went wrong");
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> insert_new_form_data(Map<String, String> new_data) async {
    new_data['insert_form_request'] = 'true';
    print(new_data);
    try {
      final extractedData = await __call_url(new_data, 'form_request');

      if (extractedData == 1) {
        throw ('Email or Phone doesn\'t exists');
      } else if (extractedData == 2) {
        return;
      } else {
        throw ("Something went wrong");
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> insert_user_form_data(Map<String, String> new_data) async {
    new_data['insert_user_details'] = 'true';
    print(new_data);
    try {
      final extractedData = await __call_url(new_data, 'update_user_details');

      if (extractedData == 1) {
        throw ('Error updating details!');
      } else if (extractedData == 2) {
        return;
      } else {
        throw ("Something went wrong");
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
