import 'dart:ui';
import 'package:fitnessbudds/screens/main/registerSecondPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:fitnessbudds/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

final Color backgroundColor = Colors.teal;

class RegisterFirstPage extends StatefulWidget {
  final User user;

  RegisterFirstPage({Key key, @required this.user}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage>
    with SingleTickerProviderStateMixin {
  String _name, _city, _phoneNumber, _errorMessage;

  double screenWidth, screenHeight;
  int _selectedGender = 0;
  int _selectedLevel = 0;
  List<String> _level = ["מתקדם", "ממוצע", "מתחיל"];

  List<IconData> _gender = [FontAwesomeIcons.male, FontAwesomeIcons.female];
  File imageFile;

  _openGallery() async {
    File picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    }); //TODO: save picture in storage and pass the given url to circleAvatar
//    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(backgroundColor: backgroundColor, body: FirstPage());
  }

  Widget _buildGenderIcon(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (_selectedGender == index) {
              _selectedGender = null;
            } else {
              _selectedGender = index;
            }
          });
        },
        child: Container(
          width: screenWidth / 2 - 50,
          height: 30.0,
          decoration: BoxDecoration(
              color: _selectedGender == index ? Colors.teal : Colors.grey,
              borderRadius: BorderRadius.circular(3)),
          child: Icon(_gender[index],
              size: 25.0,
              color: _selectedGender == index
                  ? Colors.black
                  : Colors.black54), //Theme.of(context).primaryColor),
        ));
  }

  Widget _buildLevelContainer(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (_selectedLevel == index) {
              _selectedLevel = null;
            } else {
              _selectedLevel = index;
            }
          });
        },
        child: Container(
          width: screenWidth / 3 - 20,
          height: 30.0,
          decoration: BoxDecoration(
              color: _selectedLevel == index ? Colors.teal : Colors.grey,
              borderRadius: BorderRadius.circular(3)),
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              _level[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: _selectedLevel == index
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ), //Theme.of(context).primaryColor),
        ));
  }

//  String _validator(input, String type) {
//    if (!input.isEmpty) {
//      return "";
//    }
//    return "בלי הנתון הזה נתקשה לתאם בינך ולבין המאמן שלך";//input;
//  }

  Widget _buildTextFormField(String title, IconData icon, String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 50.0,
      color: Colors.teal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
//          Text(_validator(_name, type)),
          Flexible(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                onSaved: (input) {
                  switch (type) {
                    case "Name":
                      {
                        _name = input;
                      }
                      break;
                    case "City":
                      {
                        _city = input;
                      }
                      break;
                    case "PhoneNumber":
                      {
                        _phoneNumber = input;
                      }
                      break;
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5.0, right: 5.0),
                  hintText: title,
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget FirstPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            //child: ListView(children: <Widget>[
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'המשך היכרות',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 10),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.user.photoUrl),
                      radius: 50.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        _openGallery();
                      },
                      child: Text(
                        "שנה תמונה",
                        style: TextStyle(
                            color: Hexcolor('#0B0080'),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'לצורך מציאת המאמן המושלם בשבילך נשמח אם תספר לנו עוד על עצמך',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.right,
                    ),
                    _buildTextFormField(
                        "איך קוראים לך?", FontAwesomeIcons.user, "Name"),
//                    Text(_validator(_name, "Name")),
                    SizedBox(height: 10.0),
                    _buildTextFormField("באיזה עיר אתה אוהב להתאמן?",
                        FontAwesomeIcons.city, "City"),
//                    Text(_validator(_city, "City")),
                    SizedBox(height: 10.0),
                    _buildTextFormField("מה המספר טלפון שלך?",
                        FontAwesomeIcons.phone, "PhoneNumber"),
//                    Text(_validator(_phoneNumber, "PhoneNumber")),
                    SizedBox(height: 20.0),
                    Text("בחר תאריך לידה", textAlign: TextAlign.right),
//                    DateTimePickerWidget(
//                      dateFormat: "dd-MMMM-yyyy",
//                      initDateTime: new DateTime(1998, 5, 12),
//                      minDateTime: new DateTime(1900, 5, 12),
//                      maxDateTime: new DateTime.now(),
//                      locale: DateTimePickerLocale.en_us,
//                    ),
                    SizedBox(
                        height: 100,
                        child: CupertinoDatePicker(
                          initialDateTime: new DateTime(1998, 5, 12),
                          onDateTimeChanged: (DateTime newdate) {
                            print(newdate);
                          },
                          use24hFormat: true,
                          maximumDate: new DateTime.now(),
                          minimumYear: 1900,
                          maximumYear: 2020,
                          minuteInterval: 1,
                          mode: CupertinoDatePickerMode.date,
                        )),
                    Text(
                      'בנוסף חשוב לנו לדעת את המגדר שלך ואת הרמה הספורטיבית שלך',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: _gender
                          .asMap()
                          .entries
                          .map((MapEntry map) => _buildGenderIcon(map.key))
                          .toList(),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: _level
                          .asMap()
                          .entries
                          .map((MapEntry map) => _buildLevelContainer(map.key))
                          .toList(),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    SizedBox(height: 50.0),
                    RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RegisterSecondPage(), //ProfileScreen(user: user),
                              ));
                        },
                        child: Text('המשך'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
