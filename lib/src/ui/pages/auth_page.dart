import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/ui/pages/home_page.dart';
import 'package:news_summarizer/src/ui/pages/search_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isOTPWidgetVisible = false;
  String _otpString = "";
  final TextEditingController _phoneController = TextEditingController();

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Future<void> initPhoneAuth(BuildContext ctx) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final PhoneVerificationFailed verificationFailed = (e) {
      setState(() {
        print(e.message);
        _isLoading = false;
      });
      Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print("code sent");
      setState(() {
        _isLoading = false;
        _isOTPWidgetVisible = true;
      });
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authCredential) async {
      try {
        await _auth.signInWithCredential(authCredential);
        Navigator.popAndPushNamed(context, HomeWidget.routename);
      } catch (e) {
        Get.snackbar(
          "Error",
          "Something went wrong!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: "+91" + _phoneController.text,
      timeout: Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
        print("Timeout");
      },
    );
  }

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
      body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) => (snapshot.connectionState ==
                ConnectionState.done)
            ? Column(
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
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            enabled: !_isLoading,
                            validator: (value) {
                              if (value.length < 10) {
                                return 'Please enter a valid number!';
                              }
                              return null;
                            },
                            controller: _phoneController,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone Number',
                              hintText: '8197513721',
                              icon: Icon(Icons.phone, color: Color(0xff3B916E)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isOTPWidgetVisible,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 24,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text("Enter the OTP received"),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 32),
                          child: PinCodeTextField(
                            animationType: AnimationType.slide,
                            textInputType: TextInputType.number,
                            length: 6,
                            backgroundColor: Colors.transparent,
                            textStyle: TextStyle(
                              color: (themeProvider.theme ==
                                      themeProvider.darkTheme)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                            ),
                            pinTheme: PinTheme(
                              selectedColor: Theme.of(context).accentColor,
                              activeColor: Theme.of(context).accentColor,
                              inactiveColor: Theme.of(context).accentColor,
                              fieldWidth: 40,
                            ),
                            onCompleted: (value) {
                              setState(() {
                                _otpString = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
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
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          initPhoneAuth(context);
                        }
                      },
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
