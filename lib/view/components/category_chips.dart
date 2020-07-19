import 'package:flutter/material.dart';

// data
import 'package:news_feed/data/category_info.dart';

class CategoryChips extends StatefulWidget {
  final ValueChanged onCategorySelected;

  CategoryChips({this.onCategorySelected});

  @override
  _CategoryChipsState createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      children: List<Widget>.generate(
        categories.length,
        (int index) => ChoiceChip(
          label: Text(categories[index].nameJp),
          selected: selectedIndex == index,
          onSelected: (bool isSelected) {
            setState(() {
              selectedIndex = isSelected ? index : 0;
              widget.onCategorySelected(categories[index]);
            });
          },
        ),
      ).toList(),
    );
  }
}
