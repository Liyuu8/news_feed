import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// style
import 'package:news_feed/view/style/styles.dart';

// view_models
import 'package:news_feed/view_models/news_list_view_model.dart';

// screens
import 'view/screens/home_screen.dart';

void main() => runApp(
      ChangeNotifierProvider<NewsListViewModel>(
        create: (context) => NewsListViewModel(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsFeed',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: BoldFont,
      ),
      home: HomeScreen(),
    );
  }
}
