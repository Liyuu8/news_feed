import 'package:flutter/material.dart';

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
  onRefresh(BuildContext context) {
    print('NewsListPage.onRefresh: clicked');
  }

  // TODO: キーワード記事取得処理
  getKeywordNews(BuildContext context, keyword) {
    print('NewsListPage.getKeywordNews: (keyword: $keyword)');
  }

  // TODO: カテゴリー記事取得処理
  getCategoryNews(BuildContext context, Category category) {
    print('NewsListPage.getCategoryNews: (category: ${category.nameJp})');
  }
}
