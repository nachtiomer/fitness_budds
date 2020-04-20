import 'package:fitnessbudds/screens/main/registerScreen/textFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitnessbudds/screens/main/registerScreen/textFormField.dart';

class AddActivityPage extends StatefulWidget {
  @override
  _AddActivityPageState createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:  ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            SizedBox(height: 50,),
            Text(
              "הוסף פעילות חסרה",
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height:300),
            TextFormFieldWidget(title: "פעילות חסרה"),
            Divider(),
            FloatingActionButton(
              heroTag: "11111",
              child: Icon(FontAwesomeIcons.plus),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
