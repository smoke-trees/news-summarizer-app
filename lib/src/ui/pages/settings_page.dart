import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/ui/pages/preferences_page.dart';
import 'package:news_summarizer/src/ui/widgets/theme_dialog.dart';

class SettingPage extends StatelessWidget {
  Future<void> _showThemeDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ThemeDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Get.theme.accentColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: InkWell(
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Change Theme",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Get.theme.accentColor,
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                _showThemeDialog(context);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Change News Preferences",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Get.theme.accentColor,
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferencesPage(),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
