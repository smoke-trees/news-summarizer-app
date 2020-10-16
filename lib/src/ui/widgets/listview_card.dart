import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListViewCard extends StatefulWidget {
  final int index;
  final Key key;
  final List<String> listItems;

  ListViewCard(this.listItems, this.index, this.key);

  @override
  _ListViewCard createState() => _ListViewCard();
}

class _ListViewCard extends State<ListViewCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlineButton(
        onPressed: () {},
        splashColor: Color(0xff3B916E),
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        borderSide: BorderSide(color: Color(0xff3B916E)),
        highlightedBorderColor: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.listItems[widget.index].contains("NewsFeed.")
                          ? widget.listItems[widget.index]
                              .substring(9)
                              .toLowerCase()
                              .split("_")
                              .map((e) => e.capitalizeFirst("123")).join(" ")
                              .toString()
                          : widget.listItems[widget.index]
                              .split("_")
                              .map((e) => e.capitalizeFirst("123")).join(" ")
                              .toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.left,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.reorder,
                color: Get.theme.accentColor,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
