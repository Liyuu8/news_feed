import 'package:flutter/material.dart';

// data
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';

// repository
import 'package:news_feed/repository/news_repository.dart';

class NewsListViewModel extends ChangeNotifier {
  final NewsRepository _repository = NewsRepository();

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  String _keyword = '';
  String get keyword => _keyword;

  Category _category = categories[0];
  Category get category => _category;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // TODO: ニュース取得処理
  Future<void> getNews({
    @required SearchType searchType,
    String keyword,
    Category category,
  }) async {
    _searchType = searchType;
    _keyword = keyword;
    _category = category;

    _isLoading = true;
    notifyListeners();

    await _repository.getNews(
      searchType: _searchType,
      keyword: _keyword,
      category: _category,
    );

    _isLoading = true;
    notifyListeners();
  }
}
