import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chopper/chopper.dart';

// data
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/load_status.dart';
import 'package:news_feed/data/search_type.dart';

// models
import 'package:news_feed/models/db/dao.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/models/networking/api_service.dart';

// util
import 'package:news_feed/util/extensions.dart';

class NewsRepository extends ChangeNotifier {
  final String _apiKey = DotEnv().env['api_key'];
  final ApiService _apiService;
  final NewsDao _dao;

  NewsRepository({dao, apiService})
      : _apiService = apiService,
        _dao = dao;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  Future<void> getNews({
    @required SearchType searchType,
    String keyword,
    Category category,
  }) async {
    _loadStatus = LoadStatus.LOADING;
    notifyListeners();

    Response response;
    try {
      switch (searchType) {
        case SearchType.HEAD_LINE:
          response = await _apiService.getHeadlines(apiKey: _apiKey);
          break;
        case SearchType.KEYWORD:
          response = await _apiService.getKeywordNews(
              keyword: keyword, apiKey: _apiKey);
          break;
        case SearchType.CATEGORY:
          response = await _apiService.getCategoryNews(
              category: category.nameEn, apiKey: _apiKey);
          break;
      }

      if (response.isSuccessful) {
        await _insertAndReadFromDB(response.body);
        _loadStatus = LoadStatus.DONE;
      } else {
        print('response is not successful. '
            '(status code: ${response.statusCode} / ${response.error})');
        _loadStatus = LoadStatus.RESPONSE_ERROR;
      }
    } on Exception catch (e) {
      print('exception happened. (error: $e)');
      _loadStatus = LoadStatus.NETWORK_ERROR;
    } finally {
      notifyListeners();
    }
  }

  // Webからの取得結果を一旦DBに一時格納（キャッシュ）するためのメソッド
  Future<void> _insertAndReadFromDB(responseBody) async {
    final articlesFromNetwork = News.fromJson(responseBody).articles;

    // Webから取得した記事リストを（Dartのモデルクラス：Article）をDBのテーブルクラス（Articles）に
    // 変換してDBに格納して、DBから格納結果を取得する
    final articlesFromDB = await _dao.insertAndReadNewsFromDB(
      articlesFromNetwork.toArticleRecords(articlesFromNetwork),
    );

    // DBから取得したデータをモデルクラスに再変換
    _articles = articlesFromDB.toArticles(articlesFromDB);
  }

  @override
  void dispose() {
    super.dispose();
    _apiService.dispose();
  }
}
