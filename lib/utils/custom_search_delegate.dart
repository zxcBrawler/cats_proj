import 'package:cats_proj/cat_info.dart';
import 'package:cats_proj/utils/cat.dart';
import 'package:cats_proj/utils/cat_data.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: catList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatInfo(cat: catList[index]),
                ));
          },
          child: ListTile(
            title: Text(catList[index].name),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Cat> suggestionList = query.isEmpty
        ? []
        : catList
            .where((item) =>
                item.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatInfo(
                      cat: catList
                          .where((element) =>
                              element.name == suggestionList[index].name)
                          .toList()
                          .first),
                ));
          },
          child: ListTile(
            title: Text(suggestionList[index].name),
          ),
        );
      },
    );
  }
}
