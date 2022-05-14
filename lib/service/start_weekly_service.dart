import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:psicodoc/service/config.dart';


Future<Map<String, dynamic>> start_weekly_service(String email, String username, String feeling) async {
  var client = http.Client();
  var url = Uri.parse(Config().base_url + "feeling/");
  var response = await client.post(url, body: jsonEncode(
      <String, String>{
        'email': email,
        'username': username,
        'feeling': feeling
      }),
  );

  Map<String, dynamic> r = jsonDecode(response.body);
  return r;
}