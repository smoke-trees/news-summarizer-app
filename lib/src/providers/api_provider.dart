import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_summarizer/src/models/summary.dart';

class ApiProvider with ChangeNotifier {
  SummaryResponse response;
  String searchTerm;

  setSummary(SummaryResponse response) {
    this.response = response;
    notifyListeners();
  }

  setSearchTerm(String searchTerm) {
    this.searchTerm = searchTerm;
    notifyListeners();
  }
}
