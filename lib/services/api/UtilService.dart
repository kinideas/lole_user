import 'package:shared_preferences/shared_preferences.dart';

class UtilService {
  Future<bool> saveInfoToCache(
      {required String value, required String key}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('$key', value ?? "");

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getInfoFromCache({required String key}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String result = await prefs.getString('$key')!;

      return result;
    } catch (e) {
      return "";
    }
  }
  
}
