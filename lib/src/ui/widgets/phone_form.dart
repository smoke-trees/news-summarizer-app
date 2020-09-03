import 'package:flutter/material.dart';

class PhoneForm extends StatefulWidget {
  static final formkey = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() => PhoneFormState();
}

class PhoneFormState extends State<PhoneForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: PhoneForm.formkey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value.length < 10) {
                return 'Please enter a valid number!';
              }
              return null;
            },
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Phone Number',
              hintText: '8197513721',
              icon: Icon(Icons.phone, color: Color(0xff3B916E)),
            ),
            onSaved: (value) {},
          ),
        ],
      ),
    );
  }
}
