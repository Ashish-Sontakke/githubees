import 'package:flutter/material.dart';
import 'package:githubees/UI/widgets/userTile.dart';
import 'package:githubees/models/githubUser.dart';
import 'package:githubees/services/bookmarkService.dart';

class BookmarkedSearchResults extends StatelessWidget {
  final String searchString;

  BookmarkedSearchResults({this.searchString});

  Future<List<GithubUser>> search() async {
    List<GithubUser> resultUsers = bookmarkedUsers
        .where((element) => element.login.toLowerCase().contains(searchString))
        .toList();
    return resultUsers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: search(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                  color: Colors.black,
                )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Bookmarked Users"),
                      ),
                      snapshot.data.length != null && snapshot.data.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return UserTile(
                                  user: snapshot.data[index],
                                );
                              })
                          : Center(child: Text("No Matching Results")),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
