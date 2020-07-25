import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// models
import 'package:news_feed/models/model/news_model.dart';

// view models
import 'package:news_feed/view_models/news_list_view_model.dart';

// data
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';

// components
import 'package:news_feed/view/components/article_tile.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/view/components/search_bar.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
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
          onPressed: () => onRefresh(context),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                // TODO: 検索バー
                SearchBar(
                  onSearch: (keyword) => getKeywordNews(context, keyword),
                ),
                // TODO: カテゴリー選択チップ
                CategoryChips(
                  onCategorySelected: (category) =>
                      getCategoryNews(context, category),
                ),
                Expanded(
                  child: Consumer<NewsListViewModel>(
                    builder: (context, model, child) => model.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: model.articles.length,
                            itemBuilder: (context, index) => ArticleTile(
                              article: model.articles[index],
                              onArticleClicked: (article) =>
                                  _openArticleWebPage(article, context),
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

  Future<void> onRefresh(BuildContext context) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
  }

  Future<void> getKeywordNews(BuildContext context, keyword) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categories[0],
    );
  }

  Future<void> getCategoryNews(BuildContext context, Category category) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
  }

  // TODO: 記事をウェブページにて表示する処理
  _openArticleWebPage(Article article, BuildContext context) {
    print('NewsListPage._openArticleWebPage: articleUrl is ${article.url}');
  }
}
