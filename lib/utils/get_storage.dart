import 'package:get_storage/get_storage.dart';

class Storage {
  static final getPreference = GetStorage();

  static Future<void> write(String key, dynamic value) {
    return getPreference.write(key, value);
  }

  static T? read<T>(String key) {
    return getPreference.read<T>(key);
  }

  static Future<void> deleteAll() {
    return getPreference.erase();
  }
}
