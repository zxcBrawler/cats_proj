import 'package:flutter/material.dart';

class BuildFilterChips {

  static Widget buildFilterChips({
    required String title,
    required List<String> filterOptions,
    required List<String> selectedFilters,
    required Function(String, bool) onFilterSelected,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: filterOptions.map((filter) {
            return FilterChip(
              label: Text(filter),
              selected: selectedFilters.contains(filter),
              onSelected: (bool selected) {
                onFilterSelected(filter, selected);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
