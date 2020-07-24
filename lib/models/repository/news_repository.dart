import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chopper/chopper.dart';

// data
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';

// models
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/models/networking/api_service.dart';

class NewsRepository {
  final ApiService _apiService = ApiService.create();
  final String _apiKey = DotEnv().env['api_key'];

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
        // TODO: delete
        print('responseBody: ${response.body}');
        result = News.fromJson(response.body).articles;
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
}
