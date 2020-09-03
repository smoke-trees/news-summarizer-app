import 'package:flutter/material.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/ui/widgets/phone_form.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News Summarizer',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.tonality),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(24),
            alignment: Alignment.centerLeft,
            child: Text(
              "Let's get you started!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.all(24),
            child: PhoneForm(),
          ),
          Container(
            margin: EdgeInsets.all(24),
            width: 100,
            height: 45,
            child: MaterialButton(
              child: Text(
                "NEXT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
