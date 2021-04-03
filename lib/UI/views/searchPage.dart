import 'package:flutter/material.dart';
import 'package:githubees/UI/widgets/bookmarkedSearchResults.dart';
import 'package:githubees/UI/widgets/fetchedSearchResults.dart';

class SearchPageView extends StatefulWidget {
  @override
  _SearchPageViewState createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  String searchString;

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchString = searchController.text;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    labelText: "Search"),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: searchString != null
            ? ListView(
                shrinkWrap: true,
                children: [
                  BookmarkedSearchResults(
                    searchString: searchString,
                  ),
                  FetchedSearchResults(
                    searchString: searchString,
                  ),
                ],
              )
            : Center(
                child: Text("Type to get results"),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
