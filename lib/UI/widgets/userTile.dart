import 'package:flutter/material.dart';
import 'package:githubees/models/githubUser.dart';
import 'package:githubees/services/bookmarkService.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final GithubUser user;

  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          side: BorderSide(color: Colors.grey)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          trailing: Consumer<BookmarkService>(builder: (context, service, _) {
            if (bookmarkedUsers.firstWhere((element) => element.id == user.id,
                    orElse: () => null) !=
                null) {
              return IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: Colors.indigoAccent,
                  ),
                  onPressed: () {
                    Provider.of<BookmarkService>(context, listen: false)
                        .deleteUser(user);
                  });
            }
            return IconButton(
              icon: Icon(Icons.bookmark_border),
              onPressed: () {
                Provider.of<BookmarkService>(context, listen: false)
                    .bookMarkUser(user);
              },
            );
          }),
          title: Text("${user.login}"),
        ),
      ),
    );
  }
}
