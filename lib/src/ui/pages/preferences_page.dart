import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/models/user.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/reorder_prefs_onboarding_page.dart';
import 'package:news_summarizer/src/ui/pages/reorder_prefs_page.dart';
import 'package:news_summarizer/src/ui/widgets/or_divider.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';
import 'package:news_summarizer/src/utils/hive_prefs.dart';
import 'package:provider/provider.dart';

class PreferencesPage extends StatefulWidget {
  static const routeName = "/preferences";

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool isNewUser = Get.arguments ?? false;
  var _newsBox = Hive.box(NEWS_PREFS_BOX);

  List<String> popularChosen = [];

  // var metroChosen = [];
  // var indianCitiesChosen = [];
  List<String> internationalChosen = [];

  List<String> allPrefs = [];

  List<String> customPrefsChosen = [];
  List<String> customPrefsPresent = [];
  TextEditingController customPrefsController = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    popularChosen = _newsBox.get(NEWS_POPULAR);
    // metroChosen = _newsBox.get(NEWS_METRO);
    // indianCitiesChosen = _newsBox.get(NEWS_OTHER);
    internationalChosen = _newsBox.get(NEWS_INT);
    allPrefs = _newsBox.get(NEWS_PREFS) ?? [];
    customPrefsChosen = _newsBox.get(NEWS_CUSTOM) ?? [];

    customPrefsPresent.addAll(customPrefsChosen);
  }

  void finishSelection() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    print("finishSelection called");
    List<String> finList = [];
    if (!popularChosen.isNullOrBlank) {
      finList.addAll(popularChosen);
    }
    // if (!metroChosen.isNullOrBlank) {
    //   finList.addAll(metroChosen);
    // }
    // if (!indianCitiesChosen.isNullOrBlank) {
    //   finList.addAll(indianCitiesChosen);
    // }
    if (!internationalChosen.isNullOrBlank) {
      finList.addAll(internationalChosen);
    }

    // _newsBox.put(NEWS_PREFS, finList);

    // _newsBox.put(NEWS_METRO, metroChosen);
    // _newsBox.put(NEWS_OTHER, indianCitiesChosen);

    allPrefs.forEach((element) {
      if (!finList.contains(element) && !customPrefsChosen.contains(element)) {
        userProvider.unsubscribeToTopic(topic: element.toString());
      }
    });
    finList.forEach((element) {
      if (!customPrefsChosen.contains(element)) {
        userProvider.subscribeToTopic(topic: element.toString());
      }
    });
    // userProvider.setUserInProvider(setUser: new ApiUser());
    if (userProvider.user == null) {
      print("[] User not in provider, creating new User");
      userProvider.setUserInProvider(setUser: new ApiUser());
      userProvider.setNewsPreferences(prefsList: finList);
    } else {
      userProvider.setNewsPreferences(prefsList: finList);
    }
    if (userProvider.user.notifEnabledPrefs.isNull) {
      userProvider.user.notifEnabledPrefs = finList.map((e) => e.toString()).toList();
      userProvider.setNotificationPrefs(prefsList: userProvider.user.notifEnabledPrefs);
    } else {
      userProvider.user.notifEnabledPrefs.addAll(finList.map((e) => e.toString()).toList());
      userProvider.user.notifEnabledPrefs = userProvider.user.notifEnabledPrefs.toSet().toList();
      userProvider.setNotificationPrefs(prefsList: userProvider.user.notifEnabledPrefs);
    }

    List<String> stringCustomPreferences = customPrefsChosen.cast<String>();
    List<String> stringFinList = finList.map((e) => e.toString()).toList();

    stringCustomPreferences.retainWhere((value) => !stringFinList.contains(value));
    finList.addAll(stringCustomPreferences);

    if (finList.length < 3) {
      Get.snackbar(
        "Warning!",
        "Please choose at least 3 categories.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      _newsBox.put(NEWS_CUSTOM, stringCustomPreferences);
      _newsBox.put(NEWS_PREFS, finList);
      _newsBox.put(NEWS_POPULAR, popularChosen);
      _newsBox.put(NEWS_INT, internationalChosen);
      userProvider.setCustomPreferences(prefsList: stringCustomPreferences);

      ProfileHive().setIsUserLoggedIn(true);
      if (isNewUser) {
        Get.toNamed(ReorderPrefsOnboardingPage.routeName);
      } else {
        Get.toNamed(ReorderPrefsPage.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'News Preferences',
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
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Text(
                  "Create a preference that interests you!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              // SizedBox(height: 12),
              Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    ChipsChoice<dynamic>.multiple(
                      itemConfig: ChipsChoiceItemConfig(
                        selectedColor: Get.theme.accentColor,
                        unselectedColor: Get.theme.primaryColor,
                        unselectedBrightness: Get.theme.brightness,
                        selectedBrightness: Get.theme.brightness,
                      ),
                      value: customPrefsChosen,
                      options: ChipsChoiceOption.listFrom(
                        source: customPrefsChosen,
                        value: (index, item) => item,
                        label: (index, item) => item,
                      ),
                      onChanged: (val) {
                        setState(() => customPrefsChosen = val.cast<String>());
                      },
                      padding: EdgeInsets.all(8),
                      isWrapped: true,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            key: formKey,
                            child: Container(
                              width: Get.mediaQuery.size.width * 0.7,
                              child: TextFormField(
                                // decoration: InputDecoration(hintText: "Enter your custom preference"),
                                textInputAction: TextInputAction.next,
                                controller: customPrefsController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a preference';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                                onFieldSubmitted: (value) {
                                  if (formKey.currentState.validate()) {
                                    setState(() {
                                      customPrefsChosen.add(value);
                                      customPrefsPresent.add(value);
                                      customPrefsController.clear();
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Get.theme.accentColor,
                            child: IconButton(
                              icon: Icon(Icons.add),
                              color: Get.theme.primaryColor,
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  setState(() {
                                    customPrefsChosen.add(customPrefsController.text.trim());
                                    customPrefsPresent.add(customPrefsController.text.trim());
                                    customPrefsController.clear();
                                  });
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: OrDivider(
                  color: Get.theme.accentColor,
                  thickness: 2,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(16),
                child: Text(
                  "Pick from our preset preferences!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Card(
                  color: Get.theme.cardColor,
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: Container(
                      child: Text(
                        "Popular",
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
                          selectedColor: Get.theme.accentColor,
                          unselectedColor: Get.theme.primaryColor,
                          unselectedBrightness: Get.theme.brightness,
                          selectedBrightness: Get.theme.brightness,
                        ),
                        value: popularChosen,
                        options: ChipsChoiceOption.listFrom(
                          source: NewsFeed.values.sublist(0, 14).map((e) => e.toString()).toList(),
                          value: (index, item) => item,
                          label: (index, item) => item.toString().split(".").last.replaceAll("_", " "),
                        ),
                        onChanged: (val) {
                          setState(() => popularChosen = val.cast<String>());
                        },
                        padding: EdgeInsets.all(8),
                        isWrapped: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              /*

              International

              */
              Container(
                margin: EdgeInsets.all(8),
                child: Card(
                  color: Get.theme.cardColor,
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: Container(
                      child: Text(
                        "International",
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
                          selectedColor: Get.theme.accentColor,
                          unselectedColor: Get.theme.primaryColor,
                          unselectedBrightness: Get.theme.brightness,
                          selectedBrightness: Get.theme.brightness,
                        ),
                        value: internationalChosen,
                        options: ChipsChoiceOption.listFrom(
                          source: NewsFeed.values.sublist(46, 53).map((e) => e.toString()).toList(),
                          value: (index, item) => item,
                          label: (index, item) => item.toString().split(".").last.replaceAll("_", " "),
                        ),
                        onChanged: (val) {
                          setState(() => internationalChosen = val.cast<String>());
                        },
                        padding: EdgeInsets.all(8),
                        isWrapped: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              /*

              Metro Cities Card

              */
              // Container(
              //   margin: EdgeInsets.all(8),
              //   child: Card(
              //     color: Get.theme.cardColor,
              //     child: ExpansionTile(
              //       title: Container(
              //         child: Text(
              //           "Metro Cities",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18,
              //             decoration: TextDecoration.underline,
              //             decorationColor: Get.theme.accentColor,
              //           ),
              //         ),
              //       ),
              //       children: [
              //         ChipsChoice<dynamic>.multiple(
              //           itemConfig: ChipsChoiceItemConfig(
              //             selectedColor: Get.theme.accentColor,
              //             unselectedColor: Get.theme.primaryColor,
              //             unselectedBrightness: Get.theme.brightness,
              //             selectedBrightness: Get.theme.brightness,
              //           ),
              //           value: metroChosen,
              //           options: ChipsChoiceOption.listFrom(
              //             source: NewsFeed.values.sublist(14, 19),
              //             value: (index, item) => item,
              //             label: (index, item) => item.toString().split(".").last.replaceAll("_", " "),
              //           ),
              //           onChanged: (val) {
              //             setState(() => metroChosen = val);
              //           },
              //           padding: EdgeInsets.all(8),
              //           isWrapped: true,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 8),
              // /*
              //
              // Other Cities Card
              //
              // */
              // Container(
              //   margin: EdgeInsets.all(8),
              //   child: Card(
              //     color: Get.theme.cardColor,
              //     child: ExpansionTile(
              //       title: Container(
              //         child: Text(
              //           "Other Cities",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18,
              //             decoration: TextDecoration.underline,
              //             decorationColor: Get.theme.accentColor,
              //           ),
              //         ),
              //       ),
              //       children: [
              //         ChipsChoice<dynamic>.multiple(
              //           itemConfig: ChipsChoiceItemConfig(
              //             selectedColor: Get.theme.accentColor,
              //             unselectedColor: Get.theme.primaryColor,
              //             unselectedBrightness: Get.theme.brightness,
              //             selectedBrightness: Get.theme.brightness,
              //           ),
              //           value: indianCitiesChosen,
              //           options: ChipsChoiceOption.listFrom(
              //             source: NewsFeed.values.sublist(19, 46),
              //             value: (index, item) => item,
              //             label: (index, item) => item.toString().split(".").last.replaceAll("_", " "),
              //           ),
              //           onChanged: (val) {
              //             setState(() => indianCitiesChosen = val);
              //           },
              //           padding: EdgeInsets.all(8),
              //           isWrapped: true,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 8,
              // ),
              // Container(
              //   margin: EdgeInsets.all(8),
              //   child: Card(
              //     color: Get.theme.cardColor,
              //     child: ExpansionTile(
              //         title: Container(
              //           child: Text(
              //             "Custom",
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 18,
              //               decoration: TextDecoration.underline,
              //               decorationColor: Get.theme.accentColor,
              //             ),
              //           ),
              //         ),
              //         children: [
              //           ChipsChoice<dynamic>.multiple(
              //             itemConfig: ChipsChoiceItemConfig(
              //               selectedColor: Get.theme.accentColor,
              //               unselectedColor: Get.theme.primaryColor,
              //               unselectedBrightness: Get.theme.brightness,
              //               selectedBrightness: Get.theme.brightness,
              //             ),
              //             value: customPrefsChosen,
              //             options: ChipsChoiceOption.listFrom(
              //               source: customPrefsChosen,
              //               value: (index, item) => item,
              //               label: (index, item) => item,
              //             ),
              //             onChanged: (val) {
              //               setState(() => customPrefsChosen = val);
              //             },
              //             padding: EdgeInsets.all(8),
              //             isWrapped: true,
              //           ),
              //           Container(
              //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //             child: Form(
              //               key: formKey,
              //               child: TextFormField(
              //                 autofocus: true,
              //                 decoration: InputDecoration(hintText: "Enter your custom preference"),
              //                 textInputAction: TextInputAction.next,
              //                 controller: customPrefsController,
              //                 validator: (value) {
              //                   if (value.isEmpty) {
              //                     return 'Please enter a preference';
              //                   }
              //                   return null;
              //                 },
              //                 onSaved: (value) {},
              //                 onFieldSubmitted: (value) {
              //                   if (formKey.currentState.validate()) {
              //                     setState(() {
              //                       customPrefsChosen.add(value);
              //                       customPrefsPresent.add(value);
              //                       customPrefsController.clear();
              //                     });
              //                   }
              //                 },
              //               ),
              //             ),
              //           ),
              //         ]),
              //   ),
              // ),
              SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
