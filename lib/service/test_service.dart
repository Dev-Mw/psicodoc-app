import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:psicodoc/service/config.dart';


Future<Map<String, dynamic>> test_service(String email, String username, Map<String, String> test) async {
  var client = http.Client();
  var url = Uri.parse(Config().base_url + "test/");
  var response = await client.post(url, body: jsonEncode(
      <String, dynamic>{
        'email': email,
        'username': username,
        'test': test
      }),
  );

  Map<String, dynamic> r = jsonDecode(response.body);
  return r;
}