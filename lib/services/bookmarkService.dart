import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:githubees/models/githubUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<GithubUser> bookmarkedUsers = [];

class BookmarkService extends ChangeNotifier {
  SharedPreferences _preferences;

  bookMarkUser(GithubUser user) async {
    bookmarkedUsers.add(user);
    _preferences = await SharedPreferences.getInstance();
    List<String> bookmarkedUsersStringList =
        bookmarkedUsers.map((e) => jsonEncode(e.toMap())).toList();
    _preferences.setStringList('bookmarkedUsers', bookmarkedUsersStringList);
    notifyListeners();
  }

  deleteUser(GithubUser user) async {
    try {
      bookmarkedUsers.remove(user);
      _preferences = await SharedPreferences.getInstance();
      List<String> bookmarkedUsersStringList =
          bookmarkedUsers.map((e) => jsonEncode(e.toMap())).toList();
      _preferences.setStringList('bookmarkedUsers', bookmarkedUsersStringList);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
