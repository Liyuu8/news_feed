import 'package:news_feed/models/db/database.dart';
import 'package:news_feed/models/model/news_model.dart';

// Dartのモデルクラス → DBのモデルクラス
extension ConvertToArticleRecord on List<Article> {
  List<ArticleRecord> toArticleRecords(List<Article> articles) => articles
      .map(
        (article) => ArticleRecord(
          title: article.title ?? '',
          description: article.description ?? '',
          url: article.url ?? '',
          urlToImage: article.urlToImage ?? '',
          publishDate: article.publishDate ?? '',
          content: article.content ?? '',
        ),
      )
      .toList();
}

// DBのモデルクラス → Dartのモデルクラス
extension ConvertToArticle on List<ArticleRecord> {
  List<Article> toArticles(List<ArticleRecord> articleRecodes) => articleRecodes
      .map(
        (articleRecode) => Article(
          title: articleRecode.title ?? '',
          description: articleRecode.description ?? '',
          url: articleRecode.url ?? '',
          urlToImage: articleRecode.urlToImage ?? '',
          publishDate: articleRecode.publishDate ?? '',
          content: articleRecode.content ?? '',
        ),
      )
      .toList();
}
