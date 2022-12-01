// import 'dart:convert';
// import 'dart:io';
//
// import 'package:meta/meta.dart';
// import 'cached_data.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
//
// class CachedDataManager {
//   static CachedDataManager get instance {
//     if (_instance == null) {
//       _instance = CachedDataManager();
//     }
//
//     return _instance;
//   }
//
//   static late CachedDataManager _instance;
//   late Box _box;
//
//   init() async {
//     Directory dir = await getApplicationDocumentsDirectory();
//     Hive.init(dir.path);
//     _box = await Hive.openBox("local_data");
//   }
//
//   Future<void> writeData({
//     required String key,
//     required BaseLocalData data,
//     required Duration duration,
//   }) async {
//     CachedModel model = CachedModel(
//         body: jsonEncode(data.toJson()),
//         expirtedTime: DateTime.now().add(duration));
//     String s = jsonEncode(model.toJson());
//     return await _box.put(key, s);
//   }
//
//   bool getLoginState() {
//     return  _box.get("logon", defaultValue: false);
//   }
//
//   Future<void> setLoginState(bool state) async {
//     return await _box.put("logon", state);
//   }
//
//   Future<String> getVersion() async {
//     return _box.get("version",defaultValue: "");
//   }
//
//   Future<void> setVersion(String version) async{
//     return await _box.put("version",version);
//   }
//
//   bool getLanguage() {
//     return  _box.get("vn", defaultValue: true);
//   }
//
//   Future<void> setLanguage(bool state) async{
//     return await _box.put("vn", state);
//   }
//
//   Future<void> writeJsonData({
//     required String key,
//     required String json,
//     required Duration duration,
//   }) async {
//     CachedModel model =
//         CachedModel(body: json, expirtedTime: DateTime.now().add(duration));
//     String s = jsonEncode(model.toJson());
//     return await _box.put(key, s);
//   }
//
//   // Future<String> getJsonData({required String key}) async {
//   //   String s = _box.get(key);
//   //
//   //   if (s != null) {
//   //     Map map = jsonDecode(s);
//   //     CachedModel model = CachedModel.fromJson(map);
//   //
//   //     if (model != null) {
//   //       if (DateTime.now().isBefore(model.expirtedTime)) {
//   //         return model.body;
//   //       } else {
//   //         await removeData(key);
//   //         return null;
//   //       }
//   //     }
//   //   }
//   //
//   //   return null;
//   // }
//
//   Future<void> removeData(String key) async {
//     await _box.delete(key);
//   }
// }
