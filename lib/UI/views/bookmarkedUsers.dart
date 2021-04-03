import 'package:flutter/material.dart';
import 'package:githubees/UI/widgets/userTile.dart';
import 'package:githubees/services/bookmarkService.dart';
import 'package:provider/provider.dart';

class BookMarkedUsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkService>(builder: (context, service, _) {
      return ListView.builder(
          itemCount: bookmarkedUsers.length,
          itemBuilder: (context, index) {
            return UserTile(
              user: bookmarkedUsers[index],
            );
          });
    });
  }
}
