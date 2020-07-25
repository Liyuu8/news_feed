import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

// style
import 'package:news_feed/view/style/styles.dart';

// view_models
import 'package:news_feed/view_models/head_line_view_model.dart';
import 'package:news_feed/view_models/news_list_view_model.dart';

// screens
import 'view/screens/home_screen.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<NewsListViewModel>(
        create: (_) => NewsListViewModel(),
      ),
      ChangeNotifierProvider<HeadLineViewModel>(
        create: (_) => HeadLineViewModel(),
      ),
    ],
    child: MyApp(),
  ));
}

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
