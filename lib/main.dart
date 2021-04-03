import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:githubees/models/githubUser.dart';
import 'package:githubees/services/bookmarkService.dart';
import 'package:githubees/services/networkService.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookmarkService>(
          create: (context) => BookmarkService(),
        ),
        ChangeNotifierProvider<NetworkService>(
          create: (context) => NetworkService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InitialiseApp(),
      ),
    );
  }
}

class InitialiseApp extends StatelessWidget {
  SharedPreferences preferences;
  initialise(BuildContext context) async {
    preferences = await SharedPreferences.getInstance();
    try {
      List<String> bookmarkedUsersStringList =
          preferences.getStringList('bookmarkedUsers');
      List<GithubUser> savedBookmarks = bookmarkedUsersStringList
          .map((e) => GithubUser.fromMap(jsonDecode(e)))
          .toList();
      bookmarkedUsers = savedBookmarks;

      Provider.of<NetworkService>(context, listen: false)
          .fetchUsers(http.Client());

      return true;
    } catch (e) {
      return e;
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialise(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return Container(
              child: Center(
                child: Text('Loading Data'),
              ),
            );
          }
        });
  }
}
