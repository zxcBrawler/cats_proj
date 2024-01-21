import 'dart:math';

import 'package:cats_proj/cat_info.dart';
import 'package:cats_proj/pages/page_one.dart';
import 'package:cats_proj/pages/page_two.dart';
import 'package:cats_proj/utils/cat_data.dart';
import 'package:cats_proj/utils/colors.dart';
import 'package:cats_proj/utils/custom_search_delegate.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedTabIndex = 0;

  final List<Widget> _pages = [const PageOne(), const PageTwo()];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My cat app'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                    value: 'countAll', child: Text('Count all')),
                const PopupMenuItem(
                    value: 'countKittens', child: Text('Count kittens')),
              ];
            },
            onSelected: (value) {
              if (value == 'countAll') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Count all'),
                    content: Text('${catList.length}'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 3),
                    elevation: 6.0,
                    backgroundColor: CustomColors.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Add rounded corners
                    ),
                    action: SnackBarAction(
                      label: 'Dismiss',
                      textColor:
                          Colors.white, // Set text color for action button
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                    content: Text(
                      'Total kittens: ${catList.where((element) => element.age <= 2).length}',
                      style: const TextStyle(
                        color: CustomColors.textColor,
                      ),
                    )));
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountEmail: const Text('best cats here!'),
              currentAccountPicture: Image.asset('assets/images/pet-love.png'),
              accountName: const Text(
                'My cats app',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              decoration: const BoxDecoration(color: CustomColors.accentColor),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _onTabSelected(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Facts about cats'),
              onTap: () {
                Navigator.pop(context);
                _onTabSelected(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shuffle),
              title: const Text('Get random cat'),
              onTap: () {
                Random random = Random();
                int randomCat = random.nextInt(8);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CatInfo(cat: catList[randomCat]),
                    ));
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Facts about cats',
          ),
        ],
      ),
    );
  }
}
