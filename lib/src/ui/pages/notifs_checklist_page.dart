import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/base_page.dart';
import 'package:provider/provider.dart';

class NotifsChecklistPage extends StatefulWidget {
  static String routeName = "/notifs_checklist_page";

  @override
  _NotifsChecklistPageState createState() => _NotifsChecklistPageState();
}

class _NotifsChecklistPageState extends State<NotifsChecklistPage> {
  List<String> allPrefs = [];
  List<String> enabledPrefs = [];

  @override
  void initState() {
    super.initState();
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    allPrefs.addAll(userProvider.user.newsPreferences.map((e) => e.toString()));
    allPrefs.addAll(userProvider.user.blogPreferences.cast<String>());
    // allPrefs.map((e) => e.split(".").last.replaceAll("_", " ").toUpperCase());
    enabledPrefs = userProvider.user.notifEnabledPrefs ?? [];
    allPrefs.retainWhere((element) => !userProvider.user.customPreferences.contains(element));
    print(enabledPrefs);
    print(allPrefs);
  }

  void finishSelection() async {
    Get.toNamed(BasePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Get.theme.accentColor,
          ),
        ),
        actions: [
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text(
                "You will receive Push Notifications of popular news from these channels:",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Column(
              children: allPrefs
                  .map((e) => Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e.split(".").last.replaceAll("_", " ").toUpperCase()),
                              Checkbox(
                                  value: enabledPrefs.contains(e),
                                  onChanged: (bool status) {
                                    setState(() {
                                      if (!status) {
                                        userProvider.user.notifEnabledPrefs.remove(e);
                                        userProvider.unsubscribeToTopic(topic: e.replaceAll(' ', ''));
                                        userProvider.setNotificationPrefs(prefsList: userProvider.user.notifEnabledPrefs);
                                      } else {
                                        userProvider.user.notifEnabledPrefs.add(e);
                                        userProvider.subscribeToTopic(topic: e);
                                        userProvider.setNotificationPrefs(prefsList: userProvider.user.notifEnabledPrefs);
                                      }
                                    });
                                  })
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
