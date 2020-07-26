import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// models
import 'package:news_feed/models/db/dao.dart';
import 'package:news_feed/models/db/database.dart';
import 'package:news_feed/models/networking/api_service.dart';
import 'package:news_feed/models/repository/news_repository.dart';

// view models
import 'package:news_feed/view_models/head_line_view_model.dart';
import 'package:news_feed/view_models/news_list_view_model.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<ApiService>(
    create: (_) => ApiService.create(),
    dispose: (_, apiService) => apiService.dispose(),
  ),
  Provider<MyDatabase>(
    create: (_) => MyDatabase(),
    dispose: (_, db) => db.close(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MyDatabase, NewsDao>(
    update: (_, db, dao) => NewsDao(db),
  ),
  ProxyProvider2<NewsDao, ApiService, NewsRepository>(
    update: (_, dao, apiService, repository) =>
        NewsRepository(dao: dao, apiService: apiService),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<HeadLineViewModel>(
    create: (BuildContext context) => HeadLineViewModel(
      repository: context.read<NewsRepository>(),
    ),
  ),
  ChangeNotifierProvider<NewsListViewModel>(
    create: (BuildContext context) => NewsListViewModel(
      repository: context.read<NewsRepository>(),
    ),
  ),
];
