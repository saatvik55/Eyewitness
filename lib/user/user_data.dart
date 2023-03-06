import 'dart:convert';

import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static User myUser = User(
    image:
        "https://media.licdn.com/dms/image/C4D03AQHG00WZZHcGbw/profile-displayphoto-shrink_800_800/0/1654256508601?e=1683763200&v=beta&t=VK7apm_Zm2v4OPLls8I57gS0bXASwX_It-k0DigE6sI",
    name: 'Test Test',
    email: 'test.test@gmail.com',
    phone: '(208) 206-5039',
    aboutMeDescription:
        'I am a Social Worker and wanted to contribute more to this.',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
