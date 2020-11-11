import 'package:chips_choice/chips_choice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/base_page.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:provider/provider.dart';

class BlogsPrefsPage extends StatefulWidget {
  static String routeName = "/blogs_prefs_page";

  @override
  _BlogsPrefsPageState createState() => _BlogsPrefsPageState();
}

class _BlogsPrefsPageState extends State<BlogsPrefsPage> {
  var _newsBox = Hive.box(NEWS_PREFS_BOX);

  Future<List<String>> authorsListFuture;

  Future<List<String>> getAuthorsList() async {
    var response = await Dio().get(BASE_URL + "authors");
    if (response.statusCode == 200) {
      return (response.data as List).cast<String>();
    }
    return ["Pranjal Srivastava", "Akash", "Ashish"];
    // return response.data;
  }

  var authorsChosen = [];

  @override
  void initState() {
    super.initState();
    authorsListFuture = getAuthorsList();
    authorsChosen = _newsBox.get(NEWS_BLOGS_AUTHORS) ?? [];
  }

  void finishSelection() {
    print("finishSelection called");
    var finList = authorsChosen.cast<String>();
    _newsBox.put(NEWS_BLOGS_AUTHORS, finList);
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setBlogPreferences(prefsList: finList);
    print("Saved to blogs authors, now list is: $finList");
    Navigator.pushNamed(context, BasePage.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'Blog Preferences',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
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
        child: Container(
          margin: EdgeInsets.all(8),
          child: FutureBuilder(
              future: authorsListFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Card(
                    color: Theme.of(context).cardColor,
                    child: ExpansionTile(
                      title: Container(
                        child: Text(
                          "Blog Authors",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            decorationColor: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      children: [
                        ChipsChoice<dynamic>.multiple(
                          itemConfig: ChipsChoiceItemConfig(
                            selectedColor: Theme.of(context).accentColor,
                            unselectedColor: Theme.of(context).primaryColor,
                            unselectedBrightness: Theme.of(context).brightness,
                            selectedBrightness: Theme.of(context).brightness,
                          ),
                          value: authorsChosen,
                          options: ChipsChoiceOption.listFrom(
                            source: snapshot.data,
                            value: (index, item) => item,
                            label: (index, item) => item.toString().split(".").last.replaceAll("_", " "),
                          ),
                          onChanged: (val) {
                            setState(() => authorsChosen = val);
                          },
                          padding: EdgeInsets.all(8),
                          isWrapped: true,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Card(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
