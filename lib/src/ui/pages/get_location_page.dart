import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class GetLocationPage extends StatefulWidget {
  static String routeName = '/get_location_page';

  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  bool _isLoading = false;
  bool _isSuccessful = false;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Location',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Allow us to view your location, so that we can serve you news related to your surroundings",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: OutlineButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  Position position =
                      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
                  userProvider.setUserLocation(position: position);
                  setState(() {
                    _isLoading = false;
                    _isSuccessful = true;
                  });
                },
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
                highlightedBorderColor: Colors.transparent,
                child: _isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      )
                    : _isSuccessful
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).accentColor,
                                child: Icon(
                                  Icons.done,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Theme.of(context).accentColor,
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                "Allow",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
