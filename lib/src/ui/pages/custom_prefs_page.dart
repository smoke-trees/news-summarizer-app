import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/base_page.dart';
import 'package:news_summarizer/src/ui/pages/blogs_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/reorder_prefs_page.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:news_summarizer/src/utils/hive_prefs.dart';
import 'package:provider/provider.dart';

class CustomPrefsPage extends StatefulWidget {
  static const routename = "/custom_prefs";

  @override
  _CustomPrefsPageState createState() => _CustomPrefsPageState();
}

class _CustomPrefsPageState extends State<CustomPrefsPage> {
  var _newsBox = Hive.box(NEWS_PREFS_BOX);
  var customPrefsChosen = [];

  var customPrefsPresent = [];
  TextEditingController customPrefsController = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    customPrefsChosen = _newsBox.get(NEWS_CUSTOM) ?? [];
    customPrefsPresent.addAll(customPrefsChosen);
  }

  void finishSelection() async {
    print("finishSelection called");
    List finList = _newsBox.get(NEWS_PREFS) ?? [];

    List<String> stringCustomPreferences = customPrefsChosen.cast<String>();
    List<String> stringFinList = finList.map((e) => e.toString()).toList();

    stringCustomPreferences.retainWhere((value) => !stringFinList.contains(value));
    finList.addAll(stringCustomPreferences);

    _newsBox.put(NEWS_CUSTOM, stringCustomPreferences);
    _newsBox.put(NEWS_PREFS, finList);

    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setCustomPreferences(prefsList: stringCustomPreferences);
    // SharedPrefs.setIsUserLoggedIn(true);
    Get.toNamed(ReorderPrefsPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Custom Preferences',
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
                setState(() => customPrefsChosen = val);
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
                        decoration: InputDecoration(hintText: "Enter your custom preference"),
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
    );
  }
}
