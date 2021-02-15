import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/ui/pages/news_web_view.dart';
import 'package:news_summarizer/src/utils/article_type_enum.dart';
import 'package:provider/provider.dart';

class DynamicLinkService {
  void initDynamicLinks(BuildContext context) async {
    print("Dynamic Links init");
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null) {
        print("path opener1");
        print(deepLink);
        print(deepLink.toString().split('/')[4]);
        ArticleType articleType =
            articleTypefromString(deepLink.toString().split('/')[3]);
        String articleId = deepLink.toString().split('/')[4];
        ApiProvider apiProvider =
            Provider.of<ApiProvider>(context, listen: false);
        Article article;
        if (articleType == ArticleType.NEWS) {
          article = await apiProvider.getArticleById(id: articleId);
        } else if (articleType == ArticleType.EXPERT) {
          article = await apiProvider.getBlogById(id: articleId);
        } else if (articleType == ArticleType.PUB) {
          article = await apiProvider.getMagazineById(id: articleId);
        }
        // await initializations();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsWebView(
              article: article,
              articleType: articleType,
            ),

          ),
        );
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print("path opener2");
      print(deepLink);
      print(deepLink.toString().split('/')[4]);
      ArticleType articleType =
      articleTypefromString(deepLink.toString().split('/')[3]);
      String articleId = deepLink.toString().split('/')[4];
      ApiProvider apiProvider =
      Provider.of<ApiProvider>(context, listen: false);
      Article article;
      if (articleType == ArticleType.NEWS) {
        article = await apiProvider.getArticleById(id: articleId);
      } else if (articleType == ArticleType.EXPERT) {
        article = await apiProvider.getBlogById(id: articleId);
      } else if (articleType == ArticleType.PUB) {
        article = await apiProvider.getMagazineById(id: articleId);
      }
      // await initializations();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewsWebView(
            article: article,
            articleType: articleType,
          ),
        ),
      );
    }
  }

  Future<String> getDynamicLink({
    Article article,
    ArticleType articleType,
  }) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://terran.page.link',
      link: Uri.parse(
        'https://terrantidings.com/${articleType.endpointType}/${article.id}',
      ),
      androidParameters: AndroidParameters(
        packageName: 'dev.smoketrees.news_summarizer',
        // minimumVersion: 1,
      ),
      // iosParameters: IosParameters(
      //   bundleId: 'com.example.ios',
      //   minimumVersion: '1.0.1',
      //   appStoreId: '123456789',
      // ),
      // googleAnalyticsParameters: GoogleAnalyticsParameters(
      //   campaign: 'example-promo',
      //   medium: 'social',
      //   source: 'orkut',
      // ),
      // itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
      //   providerToken: '123456',
      //   campaignToken: 'example-promo',
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: article.title,
        description: article.summary,
      ),
    );

    // final Uri dynamicUrl = await parameters.buildUrl();
    // print(dynamicUrl.toString());
    // return dynamicUrl.toString();
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    print(shortUrl.toString());
    return shortUrl.toString();
  }
}
