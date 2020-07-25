import 'package:flutter/material.dart';

// data
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';

// repository
import 'package:news_feed/models/repository/news_repository.dart';

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

  List<Article> _articles = [];
  List<Article> get articles => _articles;

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

    _articles = await _repository.getNews(
      searchType: _searchType,
      keyword: _keyword,
      category: _category,
    );

    // TODO: delete
    print(
        'searchType: $_searchType, keyword: $_keyword, category: ${_category.nameJp}, '
        'articleTitle: ${_articles[0].title}');

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _repository.dispose();
  }
}
