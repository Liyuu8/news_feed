import 'package:flutter/material.dart';

// data
import 'package:news_feed/data/load_status.dart';
import 'package:news_feed/data/search_type.dart';

// models
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/models/repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  final NewsRepository _repository;

  HeadLineViewModel({repository}) : _repository = repository;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  // repositoryの呼び出し
  Future<void> getHeadLines() async {
    await _repository.getNews(searchType: SearchType.HEAD_LINE);
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
