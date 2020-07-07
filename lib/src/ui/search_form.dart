import 'package:flutter/material.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/ui/search_page.dart';
import 'package:provider/provider.dart';

class SearchForm extends StatefulWidget {
  static final formkey = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() => SearchFormState();
}

class SearchFormState extends State<SearchForm> {

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);

    return Form(
      key: SearchForm.formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a search term!';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Search term',
                hintText: 'What do you want to search for?',
                border: OutlineInputBorder(),
                icon: Icon(Icons.search)),
            onSaved: (value) {
              apiProvider.setSearchTerm(value);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
        ],
      ),
    );
  }
}