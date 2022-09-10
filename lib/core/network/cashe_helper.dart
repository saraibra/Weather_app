import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static  saveData(
      {required String key, required List<String> value}) async {
   await sharedPreferences.setStringList(key, value);
  
  }
  static  saveStringData(
      {required String key, required String value}) async {
   await sharedPreferences.setString(key, value);
  
  }

  static List<String>? getData({required String key}) {
    return sharedPreferences.getStringList(key);
  }
   static String? getStringData({required String key}) {
    return sharedPreferences.getString(key);
  }
 static Future<bool> removeData({required String key}) async{
  return await  sharedPreferences.remove(key);
  }
}