import 'package:flutter/material.dart';

class PlaceholderCard {
  static Widget buildPlaceholder() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 184.850,
            )
          ],
        ),
      ),
    );
  }
}
