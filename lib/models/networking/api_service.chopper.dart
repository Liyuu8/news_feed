// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiService;

  @override
  Future<Response<dynamic>> getHeadlines(
      {String country = 'Jp', int pageSize = 10, String apiKey}) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{
      'country': country,
      'pageSize': pageSize,
      'apiKey': apiKey
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getKeywordNews(
      {String country = 'Jp',
      int pageSize = 30,
      String keyword,
      String apiKey}) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{
      'country': country,
      'pageSize': pageSize,
      'q': keyword,
      'apiKey': apiKey
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCategoryNews(
      {String country = 'Jp',
      int pageSize = 30,
      String category,
      String apiKey}) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{
      'country': country,
      'pageSize': pageSize,
      'category': category,
      'apiKey': apiKey
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
