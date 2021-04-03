import 'package:flutter/material.dart';
import 'package:githubees/UI/widgets/userTile.dart';
import 'package:githubees/services/networkService.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AllUsersView extends StatefulWidget {
  @override
  _AllUsersViewState createState() => _AllUsersViewState();
}

class _AllUsersViewState extends State<AllUsersView> {
  ScrollController controller;

  @override
  void initState() {
    controller = ScrollController()
      ..addListener(() {
        if (controller.position.maxScrollExtent == controller.position.pixels) {
          Provider.of<NetworkService>(context, listen: false)
              .fetchUsers(http.Client());
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkService>(builder: (context, service, _) {
      return RefreshIndicator(
        onRefresh: () async {
          await Provider.of<NetworkService>(context, listen: false)
              .refreshUsers(http.Client());
          return;
        },
        child: ListView(
          shrinkWrap: true,
          controller: controller,
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: fetchedUsers.length,
              itemBuilder: (context, index) {
                return UserTile(
                  user: fetchedUsers[index],
                );
              },
            ),
            Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      );
    });
  }
}
