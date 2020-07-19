import 'package:flutter/material.dart';

// data
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';

class NewsRepository {
  // TODO:
  Future<void> getNews({
    @required SearchType searchType,
    String keyword,
    Category category,
  }) async {
    print(
      'NewsRepository.getNews: '
      '(searchType: $searchType, keyword: $keyword, category: ${category.nameJp})',
    );
  }
}
