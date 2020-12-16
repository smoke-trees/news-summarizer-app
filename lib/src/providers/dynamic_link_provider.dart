import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_summarizer/src/models/article.dart';

class DynamicLinkProvider extends ChangeNotifier {
  void initDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  Future<String> getDynamicLink({Article article}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://terran.page.link',
      link: Uri.parse('https://terrantidings.com/news/${article.title}'),
      androidParameters: AndroidParameters(
        packageName: 'dev.smoketrees.news_summarizer',
        minimumVersion: 125,
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
        title: 'Terran Tidings News',
        description: 'Terran Tidings News Description',
      ),
    );

    final Uri dynamicUrl = await parameters.buildUrl();
    print(dynamicUrl.toString());
    print('https://terrantidings.com/news/${article.title}');
    return dynamicUrl.toString();
  }
}
