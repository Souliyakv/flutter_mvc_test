import 'dart:convert';

import 'package:get_storage/get_storage.dart';

final box = GetStorage();

storeUserData(user) async {
  box.write("user", jsonEncode(user));
}
