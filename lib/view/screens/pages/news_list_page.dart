import 'package:flutter/material.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view_models/news_list_view_model.dart';
import 'package:provider/provider.dart';

// data
import 'package:news_feed/data/category_info.dart';

// components
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/view/components/search_bar.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO: 更新処理
  Future<void> onRefresh(BuildContext context) async {
    final viewModel = context.read<NewsListViewModel>();
    // TODO: 未完成
    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
  }

  // TODO: キーワード記事取得処理
  Future<void> getKeywordNews(BuildContext context, keyword) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categories[0],
    );
  }

  // TODO: カテゴリー記事取得処理
  Future<void> getCategoryNews(BuildContext context, Category category) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
  }
}
