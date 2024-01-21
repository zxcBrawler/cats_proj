import 'package:cats_proj/utils/cat_facts.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: CatFacts.catFacts.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(50, 237, 150, 189),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                CatFacts.catFacts[index],
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}
