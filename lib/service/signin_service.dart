import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:psicodoc/service/config.dart';

Future<Map<String, dynamic>> signin_service(String name, String email, String age, String career, String password) async {
  var url = Uri.parse(Config().base_url + "users/");
  var response = await http.post(url, body: jsonEncode(
      <String, String>{
        'username': name,
        'email': email,
        'age': age,
        'career': career,
        'password': password
      }),
  );
  Map<String, dynamic> r = jsonDecode(response.body);
  return r;
}