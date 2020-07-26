import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// model
import 'package:news_feed/models/model/news_model.dart';

// components
import 'package:news_feed/view/components/head_line_item.dart';
import 'package:news_feed/view/components/page_transformer.dart';

// data
import 'package:news_feed/view_models/head_line_view_model.dart';

// screens
import 'package:news_feed/view/screens/news_web_page_screen.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      // 非同期処理でエラーを回避。
      Future(() => viewModel.getHeadLines());
    }
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<HeadLineViewModel>(
            builder: (context, model, child) => model.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : PageTransformer(
                    pageViewBuilder: (context, resolver) => PageView.builder(
                      controller: PageController(viewportFraction: 0.9),
                      itemCount: model.articles.length,
                      itemBuilder: (context, index) => HeadLineItem(
                        article: model.articles[index],
                        pageVisibility: resolver.resolvePageVisibility(index),
                        onArticleClicked: (article) =>
                            _openArticleWebPage(context, article),
                      ),
                    ),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => onRefresh(context),
        ),
      ),
    );
  }

  onRefresh(BuildContext context) async {
    final viewModel = context.read<HeadLineViewModel>();
    await viewModel.getHeadLines();
  }

  _openArticleWebPage(BuildContext context, Article article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsWebPageScreen(article: article),
      ),
    );
  }
}
