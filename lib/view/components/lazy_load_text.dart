import 'package:flutter/material.dart';

// components
import 'package:news_feed/view/components/page_transformer.dart';

class LazyLoadText extends StatelessWidget {
  final String text;
  final PageVisibility pageVisibility;

  LazyLoadText({this.text, this.pageVisibility});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: Alignment.topLeft,
        transform: Matrix4.translationValues(
          pageVisibility.pagePosition * 200,
          0.0,
          0.0,
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
