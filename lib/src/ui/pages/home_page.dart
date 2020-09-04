import 'package:flutter/material.dart';
import 'package:news_summarizer/src/ui/widgets/search_form.dart';

class HomeWidget extends StatelessWidget {
  static const routename = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 25.0, left: 24.0),
            child: SearchForm(),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(24),
            width: 100,
            height: 45,
            child: MaterialButton(
              child: Text(
                "Search",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              disabledColor: Theme.of(context).accentColor.withOpacity(0.7),
              color: Theme.of(context).accentColor,
              onPressed: () {
                if (SearchForm.formkey.currentState.validate()) {
                  SearchForm.formkey.currentState.save();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
