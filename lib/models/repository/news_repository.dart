import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chopper/chopper.dart';

// data
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';

// models
import 'package:news_feed/models/db/dao.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/models/networking/api_service.dart';

// util
import 'package:news_feed/util/extensions.dart';

class NewsRepository {
  final String _apiKey = DotEnv().env['api_key'];
  final ApiService _apiService;
  final NewsDao _dao;

  NewsRepository({dao, apiService})
      : _apiService = apiService,
        _dao = dao;

  Future<List<Article>> getNews({
    @required SearchType searchType,
    String keyword,
    Category category,
  }) async {
    Response response;
    List<Article> result = [];

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
        result = await insertAndReadFromDB(response.body);
      } else {
        print('response is not successful. '
            '(status code: ${response.statusCode} / ${response.error})');
      }
    } on Exception catch (e) {
      print('exception happened. (error: $e)');
    }

    return result;
  }

  void dispose() {
    _apiService.dispose();
  }

  // Webからの取得結果を一旦DBに一時格納（キャッシュ）するためのメソッド
  Future<List<Article>> insertAndReadFromDB(responseBody) async {
    final articles = News.fromJson(responseBody).articles;

    // Webから取得した記事リストを（Dartのモデルクラス：Article）をDBのテーブルクラス（Articles）に
    // 変換してDBに格納して、DBから格納結果を取得する
    final articleRecodes =
        await _dao.insertAndReadNewsFromDB(articles.toArticleRecords(articles));

    // DBから取得したデータをモデルクラスに再変換して返す
    return articleRecodes.toArticles(articleRecodes);
  }
}
