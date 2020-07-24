import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  static const BASE_URL = 'http://newsapi.org/v2';

  static ApiService create() {
    final client = ChopperClient(
      baseUrl: BASE_URL,
      services: [_$ApiService()],
      converter: JsonConverter(),
    );
    return _$ApiService(client);
  }

  @Get(path: '/top-headlines')
  Future<Response> getHeadlines({
    @Query('country') String country = 'Jp',
    @Query('pageSize') int pageSize = 10,
    @Query('apiKey') @required String apiKey,
  });

  @Get(path: '/top-headlines')
  Future<Response> getKeywordNews({
    @Query('country') String country = 'Jp',
    @Query('pageSize') int pageSize = 30,
    @Query('q') @required String keyword,
    @Query('apiKey') @required String apiKey,
  });

  @Get(path: '/top-headlines')
  Future<Response> getCategoryNews({
    @Query('country') String country = 'Jp',
    @Query('pageSize') int pageSize = 30,
    @Query('category') @required String category,
    @Query('apiKey') @required String apiKey,
  });
}
