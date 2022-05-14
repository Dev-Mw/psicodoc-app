import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:psicodoc/service/config.dart';


Future<Map<String, dynamic>> get_feeling_service(String email) async {
  var url = Uri.parse(Config().base_url + "feeling_history/");
  var response = await http.post(url, body: jsonEncode(
      <String, String>{
        'email': email,
      }),
  );
  Map<String, dynamic> r = jsonDecode(response.body);
  return r;
}