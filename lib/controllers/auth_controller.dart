import 'package:flutter/widgets.dart';

class AuthController {
  final Map<String, String> validUsers = {
    '123230188': 'Yusuf Nur Ramadhan',
    '123230115': 'Kevin Dwi Cahyadi',
    '123230137': 'M. Bintang Al-Kautsar',
    '123230042': 'M. Irham Hadi Putra',
  };

  String AuthLogin({
    required TextEditingController NIM
  }) {
    String inputNim = NIM.text.trim();
    print(inputNim);
    if (validUsers.containsKey(inputNim)) {
      String userName = validUsers[inputNim]!;
      return userName;
    } else {
      return "";
    }
  }

}
