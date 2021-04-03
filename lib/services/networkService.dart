import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:githubees/models/githubUser.dart';
import 'package:http/http.dart' as http;

List<GithubUser> fetchedUsers = [];

class NetworkService extends ChangeNotifier {
  Future<List<GithubUser>> fetchUsers(http.Client client) async {
    Uri url =
        Uri.parse('https://api.github.com/users?since=${fetchedUsers.length}');
    print("https://api.github.com/users?since=${fetchedUsers.length}");
    final response = await client.get(
      url,
    );

    final parsedUsersJson =
        jsonDecode(response.body).cast<Map<String, dynamic>>();
    List<GithubUser> resultUsers = parsedUsersJson
        .map<GithubUser>((json) => GithubUser.fromMap(json))
        .toList();

    fetchedUsers.addAll(resultUsers);
    notifyListeners();
    return fetchedUsers;
  }
}
