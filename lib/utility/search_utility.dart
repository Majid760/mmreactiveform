import 'package:flutter/material.dart';
import 'package:mmreactiveform/database/database_service.dart';

class ProfileSearch extends SearchDelegate<String> {
  List? userProfiles;

  // final GlobalKey<ScaffoldState> key;
  List recentSearchedProducts = [];
  ProfileSearch({this.userProfiles});

  @override
  List<Widget> buildActions(BuildContext context) {
    // action for Appbar,
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //action for leading
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show the build result when user pick one suggestion from different suggestions

    return Center(
      child: Container(
        color: Colors.red,
        child: const Text('this is sdi'),
      ),
    );
  }

  @override
  Future<Widget> buildSuggestions(BuildContext context) async {
    final userData = DatabaseService.instance.database;
    userProfiles = await DatabaseService.instance.getUserByName(query);

    // show some suggestion from you data , which is being searhed.
    final suggestionList = query.isEmpty
        ? recentSearchedProducts.toList()
        : userProfiles!
            .toList()
            .where((profile) => (profile['first_name'] + profile['last_name'])
                .toLowerCase()
                .contains(query))
            .toList();
    return ListView.builder(
        itemCount: suggestionList.toList().length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              // showResults(context);
            },
            title: Text(suggestionList[index]['first_name'] +
                suggestionList[index]['last_name']),
            subtitle: Text(suggestionList[index]['cnic']),
          );
        });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }
}
