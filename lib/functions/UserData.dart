import 'package:shared_preferences/shared_preferences.dart';

Future setData (String key,String val) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString(key, val);

}
Future<String> getData(key) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  String val = pref.getString(key);
  return val;
}
Future<bool> checkData(key) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool status = pref.containsKey(key);
  return status;
}
Future removeData(key) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove(key);
}


