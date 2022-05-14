import 'package:shared_preferences/shared_preferences.dart';


final prefs = SharedPreferences.getInstance();


class Config {
  String base_url = "http://192.168.20.24:8001/api/v1/";
}