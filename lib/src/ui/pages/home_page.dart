import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/ui/widgets/search_form.dart';

class HomeWidget extends StatelessWidget {
  static const routename = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Terran Tidings',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Get.theme.accentColor),
        ),
      ),
      backgroundColor: Get.theme.backgroundColor,
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
                  color: Get.theme.primaryColor,
                ),
              ),
              disabledColor: Get.theme.accentColor.withOpacity(0.7),
              color: Get.theme.accentColor,
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
