import 'package:flutter/material.dart';

class Name with ChangeNotifier {
  String _username = "Guest";
  String get username => _username;

  void change(String newUsername){
    _username = newUsername;
    notifyListeners();
  }

}