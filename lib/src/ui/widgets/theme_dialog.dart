import 'package:flutter/material.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeDialog extends StatefulWidget {
  @override
  _ThemeDialogState createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  int _selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return AlertDialog(
      title: Text('Choose a theme'),
      backgroundColor: Theme.of(context).backgroundColor,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              title: Text("Dark Theme"),
              leading: Radio(
                value: 0,
                groupValue: _selectedRadio,
                onChanged: (value) {
                  setState(() {
                    _selectedRadio = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Light Theme"),
              leading: Radio(
                value: 1,
                groupValue: _selectedRadio,
                onChanged: (value) {
                  setState(() {
                    _selectedRadio = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Update'),
          onPressed: () {
            if (_selectedRadio == 0) {
              themeProvider.setDarkTheme();
            } else {
              themeProvider.setLightTheme();
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
