import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:psicodoc/service/config.dart';


Future<Map<String, dynamic>> login_service(String email, String password) async {
  var client = http.Client();
  var url = Uri.parse(Config().base_url + "auth/");
  var response = await client.post(url, body: jsonEncode(
      <String, String>{
        'email': email,
        'password': password
      }),
  );

  Map<String, dynamic> r = jsonDecode(response.body);
  return r;
}