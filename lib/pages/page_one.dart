import 'package:cats_proj/cat_info.dart';
import 'package:cats_proj/utils/cat.dart';
import 'package:cats_proj/utils/cat_card.dart';
import 'package:cats_proj/utils/cat_data.dart';
import 'package:cats_proj/utils/filter_chips.dart';
import 'package:cats_proj/utils/placeholder.dart';
import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  bool crossfade = false;
  List<String> selectedAges = [];
  List<String> selectedGenders = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        crossfade = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Cat> filteredCats = catList
        .where((cat) =>
            (selectedGenders.contains(cat.gender)) ||
            (cat.age <= 2 && selectedAges.contains('Kitten')) ||
            (cat.age > 2 && selectedAges.contains('Mature')))
        .toList();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(children: [
              BuildFilterChips.buildFilterChips(
                title: 'Ages',
                filterOptions: ['Kitten', 'Mature'],
                selectedFilters: selectedAges,
                onFilterSelected: _onAgeSelected,
              ),
              BuildFilterChips.buildFilterChips(
                title: 'Genders',
                filterOptions: ['male', 'female'],
                selectedFilters: selectedGenders,
                onFilterSelected: _onGenderSelected,
              ),
            ]),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.9,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CatInfo(
                              cat: selectedGenders.isEmpty &&
                                      selectedAges.isEmpty
                                  ? filteredItemIndex(catList[index].name)
                                  : filteredItemIndex(
                                      filteredCats[index].name)),
                        ));
                  },
                  child: AnimatedCrossFade(
                    firstChild: selectedGenders.isEmpty && selectedAges.isEmpty
                        ? CatCard.buildCatCard(catList[index])
                        : CatCard.buildCatCard(filteredCats[index]),
                    secondChild: PlaceholderCard.buildPlaceholder(),
                    crossFadeState: crossfade
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              childCount: selectedGenders.isEmpty && selectedAges.isEmpty
                  ? catList.length
                  : filteredCats.length,
            ),
          ),
        ],
      ),
    );
  }

  void _onAgeSelected(String age, bool selected) {
    setState(() {
      if (selected) {
        selectedAges.add(age);
      } else {
        selectedAges.remove(age);
      }
    });
  }

  void _onGenderSelected(String gender, bool selected) {
    setState(() {
      if (selected) {
        selectedGenders.add(gender);
      } else {
        selectedGenders.remove(gender);
      }
    });
  }

  Cat filteredItemIndex(String catName) {
    return catList.where((element) => element.name == catName).toList().first;
  }
}
