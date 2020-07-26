import 'package:flutter/material.dart';

// data
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/load_status.dart';
import 'package:news_feed/data/search_type.dart';

// models
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/models/repository/news_repository.dart';

class NewsListViewModel extends ChangeNotifier {
  final NewsRepository _repository;

  NewsListViewModel({repository}) : _repository = repository;

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  String _keyword = '';
  String get keyword => _keyword;

  Category _category = categories[0];
  Category get category => _category;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  // repositoryの呼び出し
  Future<void> getNews({
    @required SearchType searchType,
    String keyword,
    Category category,
  }) async {
    _searchType = searchType;
    _keyword = keyword;
    _category = category;

    await _repository.getNews(
      searchType: _searchType,
      keyword: _keyword,
      category: _category,
    );
  }

  onRepositoryUpdated(NewsRepository repository) {
    _articles = repository.articles;
    _loadStatus = repository.loadStatus;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _repository.dispose();
  }
}
