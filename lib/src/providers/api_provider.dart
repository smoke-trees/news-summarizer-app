import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/models/summary.dart';
import 'package:news_summarizer/src/utils/constants.dart';

class ApiProvider with ChangeNotifier {
  SummaryResponse response;
  String searchTerm;
  final _dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 60000,
      receiveTimeout: 60000,
    ),
  );

  setSearchTerm(String searchTerm) {
    this.searchTerm = searchTerm;
    notifyListeners();
  }

  Future<List<Article>> getArticlesFromCategory({String category}) async {
    print(_dio.options.baseUrl);
    Response response = await _dio
        .get("/get_category_news", queryParameters: {'category': category});
    List<Article> articleList =
        (response.data as List).map((json) => Article.fromJson(json)).toList();
    return articleList;
  }

  Future<List<Article>> getArticlesFromSearch() async {
    Response response =
        await _dio.get("/get_news", queryParameters: {'query': searchTerm});
    List<Article> articleList =
        (response.data as List).map((json) => Article.fromJson(json)).toList();
    return articleList;
  }

  Future<List<Article>> getArticlesFromCustomPreference(
      {String customPref}) async {
    Response response =
        await _dio.get("/get_news", queryParameters: {'query': customPref});
    List<Article> articleList =
        (response.data as List).map((json) => Article.fromJson(json)).toList();
    return articleList;
  }

  Future<List<Article>> getArticlesFromBlogAuthor({String author}) async {
    Response response =
        await _dio.get("/get_author_blog", queryParameters: {'query': author});
    List<Article> articleList =
        (response.data as List).map((json) => Article.fromJson(json)).toList();
    return articleList;
  }

  Future<List<Article>> getArticlesFromPub({String source}) async {
    Response response =
        await _dio.get("/get_source_mag/", queryParameters: {"source": source});
    List<Article> articleList =
        (response.data as List).map((json) => Article.fromJson(json)).toList();
    return articleList;
  }

  Future<List<Article>> getArticlesFromLocation(
      {double latitude, double longitude}) async {
    Response response = await _dio.get("/get_location_news",
        queryParameters: {'latitude': latitude, 'longitude': longitude});
    List<Article> articleList =
        (response.data as List).map((json) => Article.fromJson(json)).toList();
    return articleList;
  }

  Future<Article> getArticleById({String id}) async {
    Response response = await _dio.get("/get_article/$id");
    Article article = Article.fromJson(response.data);
    return article;
  }

  Future<Article> getMagazineById({String id}) async {
    Response response = await _dio.get("/get_mag/$id");
    Article article = Article.fromJson(response.data);
    return article;
  }

  Future<Article> getBlogById({String id}) async {
    Response response = await _dio.get("/get_blog/$id");
    Article article = Article.fromJson(response.data);
    return article;
  }

  Future<List<Article>> getManyArticlesByIds({List<String> ids}) async {
    Response response = await _dio.post("/get_articles_by_ids/", data: ids);
    List<Article> articleList = (response.data as List)
            .map((json) => Article.fromJson(json))
            .toList() ??
        [];
    return articleList;
  }

  Future<List<Article>> getManyBlogsByIds({List<String> ids}) async {
    Response response = await _dio.post("/get_blogs_by_ids/", data: ids);
    List<Article> articleList = (response.data as List)
            .map((json) => Article.fromJson(json))
            .toList() ??
        [];
    return articleList;
  }

  Future<List<Article>> getManyPubByIds({List<String> ids}) async {
    Response response = await _dio.post("/get_mags_by_ids/", data: ids);
    List<Article> articleList = (response.data as List)
            .map((json) => Article.fromJson(json))
            .toList() ??
        [];
    return articleList;
  }

  void makeViewNews({Article article}) async {
    await _dio.post(
      "/make_view_news/",
      queryParameters: {'article_id': article.id},
    );
  }

  void makeViewBlog({Article article}) async {
    await _dio.post(
      "/make_view_blogs/",
      queryParameters: {'article_id': article.id},
    );
  }
}
