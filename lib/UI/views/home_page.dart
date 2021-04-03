import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githubees/UI/views/allUsers.dart';
import 'package:githubees/UI/views/searchPage.dart';

import 'bookmarkedUsers.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: false,
        appBar: AppBar(
          title: Text("GithuBees"),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => SearchPageView()));
                }),
          ],
        ),
        body: TabBarView(
          children: [AllUsersView(), BookMarkedUsersView()],
        ),
        bottomNavigationBar: Container(
          color: Colors.grey[200],
          child: TabBar(
            labelColor: Colors.indigoAccent,
            indicatorColor: Colors.indigoAccent,
            tabs: [
              Tab(
                text: 'Users',
              ),
              Tab(
                text: 'Bookmarked',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
