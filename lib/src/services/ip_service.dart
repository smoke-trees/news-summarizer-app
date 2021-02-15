import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:provider/provider.dart';

class IPService {
  void getLocation(BuildContext context) async {
    var response =
        await Dio().get("https://geo.ipify.org/api/v1?apiKey=$IPIFY_KEY");
    if (response.statusCode == 200) {
      print(response.data);
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      userProvider.setUserIpifyObject(object: response.data);
    } else {
      return; //TODO: Error
    }
  }
}
