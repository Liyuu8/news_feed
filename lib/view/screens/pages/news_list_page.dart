import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// model
import 'package:news_feed/models/model/news_model.dart';

// view models
import 'package:news_feed/view_models/news_list_view_model.dart';

// data
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/load_status.dart';
import 'package:news_feed/data/search_type.dart';

// components
import 'package:news_feed/view/components/article_tile.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/view/components/search_bar.dart';

// screens
import 'package:news_feed/view/screens/news_web_page_screen.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);

    if (viewModel.loadStatus != LoadStatus.LOADING &&
        viewModel.articles.isEmpty) {
      // 非同期処理でエラーを回避。
      Future(
        () => viewModel.getNews(
          searchType: SearchType.CATEGORY,
          category: categories[0],
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: '更新',
          onPressed: () => _onRefresh(context),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                // 検索バー
                SearchBar(
                  onSearch: (keyword) => _getKeywordNews(context, keyword),
                ),
                // カテゴリー選択チップ
                CategoryChips(
                  onCategorySelected: (category) =>
                      _getCategoryNews(context, category),
                ),
                // ニュースリスト
                Expanded(
                  child: Consumer<NewsListViewModel>(
                    builder: (context, model, child) =>
                        model.loadStatus == LoadStatus.LOADING
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: model.articles.length,
                                itemBuilder: (context, index) => ArticleTile(
                                  article: model.articles[index],
                                  onArticleClicked: (article) =>
                                      _openArticleWebPage(context, article),
                                ),
                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
  }

  Future<void> _getKeywordNews(BuildContext context, keyword) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categories[0],
    );
  }

  Future<void> _getCategoryNews(BuildContext context, Category category) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
  }

  _openArticleWebPage(BuildContext context, Article article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsWebPageScreen(article: article),
      ),
    );
  }
}
