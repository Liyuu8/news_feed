import 'package:flutter/material.dart';

// data
import 'package:news_feed/data/search_type.dart';

// model
import 'package:news_feed/models/model/news_model.dart';

// repository
import 'package:news_feed/models/repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  final NewsRepository _repository;

  HeadLineViewModel({repository}) : _repository = repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  Future<void> getHeadLines() async {
    _isLoading = true;
    notifyListeners();

    _articles = await _repository.getNews(searchType: SearchType.HEAD_LINE);

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _repository.dispose();
  }
}
