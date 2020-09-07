import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final String title;
  final String body;

  NewsItem(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (title != null) ? title : "No Title",
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(
            (body != null) ? body : "",
            style: TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
