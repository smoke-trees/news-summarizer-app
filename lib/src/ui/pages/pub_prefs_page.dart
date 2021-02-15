import 'package:chips_choice/chips_choice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/reorder_pubs_prefs_page.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:provider/provider.dart';

class PublicationPrefsPage extends StatefulWidget {
  static String routeName = "/pub_prefs_page";

  @override
  _PublicationPrefsPageState createState() => _PublicationPrefsPageState();
}

class _PublicationPrefsPageState extends State<PublicationPrefsPage> {
  bool isNewUser = Get.arguments ?? false;

  // var _newsBox = Hive.box(NEWS_PREFS_BOX);

  Future<List<String>> pubListFuture;

  Future<List<String>> getPubList() async {
    var response = await Dio().get(BASE_URL + "magazines");
    if (response.statusCode == 200) {
      return (response.data as List).cast<String>();
    }
    return [
      "HACKER NEWS",
      "LIFEHACKER",
      "MASHABLE",
      "WIRED",
      "NATURE",
      "VOX",
      "SIGNAL V NOISE ON MEDIUM",
      "WAIT BUT WHY"
    ];
    // return response.data;
  }

  var pubChosen = [];
  List<String> previousPubs = [];

  @override
  void initState() {
    super.initState();
    pubListFuture = getPubList();
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    pubChosen = userProvider.user.pubPreferences ?? [];

    // authorsChosen = _newsBox.get(NEWS_BLOGS_AUTHORS) ?? [];
    previousPubs = pubChosen.cast<String>();
  }

  void finishSelection() {
    print("finishSelection called");
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    var finList = pubChosen.cast<String>();

    List<String> oldEntries = userProvider.user.pubPreferences
        .where((element) => finList.contains(element))
        .toList();

    List<String> newEntries = finList
        .where(
            (element) => !userProvider.user.pubPreferences.contains(element))
        .toList();

    List<String> removedEntries = userProvider.user.pubPreferences
        .where((element) => !finList.contains(element))
        .toList();

    finList.clear();
    finList.addAll(oldEntries);
    finList.addAll(newEntries);

    removedEntries.forEach((e) => userProvider.unsubscribeToTopic(topic: e));
    newEntries.forEach((e) => userProvider.subscribeToTopic(topic: e));

    userProvider.user.notifEnabledPrefs.addAll(finList);
    userProvider.user.notifEnabledPrefs =
        userProvider.user.notifEnabledPrefs.toSet().toList();
    userProvider.setNotificationPrefs(
        prefsList: userProvider.user.notifEnabledPrefs);
    // _newsBox.put(NEWS_BLOGS_AUTHORS, finList);
    userProvider.setPubPreferences(prefsList: finList);
    print("Saved to pub, now list is: $finList");
    Get.back();
    // if (isNewUser) {
    //   Get.toNamed(BasePage.routeName);
    // } else {
    //   Get.back();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Get.theme.backgroundColor,
        appBar: AppBar(
          title: Text(
            'Publications',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Get.theme.accentColor,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {
                Get.toNamed(ReorderPubPrefsPage.routeName);
              },
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () => finishSelection(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8),
            // padding: EdgeInsets.all(8),
            child: Column(
              children: [
                // SizedBox(height: 24),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    "Choose publications you read and stay updated with them:",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: pubListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                      print(snapshot.error);
                      print(snapshot.data);
                      return Center(child: CircularProgressIndicator());
                    }
                    return Card(
                      color: Get.theme.cardColor,
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Container(
                          child: Text(
                            "Publications",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              decorationColor: Get.theme.accentColor,
                            ),
                          ),
                        ),
                        children: [
                          ChipsChoice<dynamic>.multiple(
                            itemConfig: ChipsChoiceItemConfig(
                              selectedColor: themeProvider.isDarkMode
                                  ? Get.theme.accentColor
                                  : Get.theme.primaryColorDark,
                              unselectedColor: Get.theme.primaryColor,
                              unselectedBrightness: Get.theme.brightness,
                              selectedBrightness: Get.theme.brightness,
                            ),
                            value: pubChosen,
                            options: ChipsChoiceOption.listFrom(
                              source: snapshot.data,
                              value: (index, item) => item,
                              label: (index, item) => item,
                            ),
                            onChanged: (val) {
                              setState(() => pubChosen = val);
                            },
                            padding: EdgeInsets.all(8),
                            isWrapped: true,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
