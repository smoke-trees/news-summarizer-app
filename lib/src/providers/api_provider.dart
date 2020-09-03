import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_summarizer/src/models/summary.dart';

class ApiProvider with ChangeNotifier {
  SummaryResponse response;
  String searchTerm;
  final _dio = Dio(BaseOptions(
      baseUrl: 'https://54d82a69c608.ngrok.io/',
      connectTimeout: 60000,
      receiveTimeout: 60000));

  setSummary(SummaryResponse response) {
    this.response = response;
    notifyListeners();
  }

  setSearchTerm(String searchTerm) {
    this.searchTerm = searchTerm;
    notifyListeners();
  }

  Future<List<SummaryResponse>> getSummary(String searchTerm) async {
    try {
      Response response =
          await _dio.get('/get_result', queryParameters: {'query': searchTerm});
      return (response.data as List)
          .map((e) => SummaryResponse.fromJson(e))
          .toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [SummaryResponse.withError(error.toString())];
    }
  }
}
