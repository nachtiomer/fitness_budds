import 'dart:ui';
import 'package:fitnessbudds/screens/main/registerScreen/registerSecondPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:fitnessbudds/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fitnessbudds/screens/main/registerScreen/textFormField.dart';

final Color backgroundColor = Colors.amber;

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
  bool isValidated = false;

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
              widget.user.gender = "noGender";
            } else {
              _selectedGender = index;
              widget.user.gender = _selectedGender == 0 ? "Male" : "Female";
              print(_selectedGender);
            }
          });
        },
        child: Container(
          width: screenWidth / 2 - 50,
          height: 30.0,
          decoration: BoxDecoration(
            color: _selectedGender == index
                ? Hexcolor('#192841')
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color:
                    _selectedGender == index ? Colors.white : Colors.black54),
          ),
          child: Icon(_gender[index],
              size: 25.0,
              color: _selectedGender == index
                  ? Colors.white
                  : Colors.black54
                      .withOpacity(0.2)), //Theme.of(context).primaryColor),
        ));
  }

  Widget _buildLevelContainer(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (_selectedLevel == index) {
              _selectedLevel = index;
            } else {
              _selectedLevel = index;
              widget.user.level = _selectedLevel == 0
                  ? "מתקדם"
                  : (_selectedLevel == 1 ? "ממוצע" : "מתחיל");
            }
          });
        },
        child: Container(
          width: screenWidth / 3 - 20,
          height: 30.0,
          decoration: BoxDecoration(
            color: _selectedLevel == index
                ? Hexcolor('#192841')
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: _selectedLevel == index
                    ? Colors.white
                    : Colors.white.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              _level[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _selectedLevel == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.2),
                  fontWeight: _selectedLevel == index
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ), //Theme.of(context).primaryColor),
        ));
  }

  String _validator(input, String type) {
    if (input != null && !input.isEmpty) {
      isValidated = true;
      return "";
    }
    isValidated = false;
    return "בלי הנתון הזה נתקשה לתאם בינך ולבין המאמן שלך"; //input;
  }

  void _showcontent() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You clicked on'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a Dialog Box. Click OK to Close.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget FirstPage() {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Hexcolor("#192841")),
      child: SafeArea(
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
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
//                          gradient: LinearGradient(begin: Alignment.topRight,
//                              end:Alignment.bottomRight,
//                              colors: [Colors.red.shade900,Colors.red.withOpacity(0.4)]),
                          borderRadius: BorderRadius.circular(10),
//                          color: Colors.amber.withOpacity(0.6),
                        ),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  widget.user.userName,
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                    widget.user.workoutCity == null
                                        ? ""
                                        : "מחפש להתאמן ב" +
                                            widget.user.workoutCity,
                                    textAlign: TextAlign.right),
                                Text(
                                    widget.user.phoneNumber == null
                                        ? ""
                                        : widget.user.phoneNumber,
                                    textAlign: TextAlign.right),
                              ],
                            ),
                            SizedBox(width: 10.0),
                            Column(
                              children: <Widget>[
                                Container(
                                    child: GestureDetector(
                                        onTap: () {
                                          _openGallery();
                                        },
                                        child:CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(widget.user.photoUrl),
                                        radius: 50.0,
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.blue)),
                                    padding: const EdgeInsets.all(2.0),
                                    // borde width
                                    decoration: new BoxDecoration(
                                      color: const Color(0xFFFFFFFF),
                                      // border color
                                      shape: BoxShape.circle,
                                    )),
//                                GestureDetector(
//                                  onTap: () {
//                                    _openGallery();
//                                  },
//                                  child: Text(
//                                    "שנה תמונה",
//                                    style: TextStyle(
//                                        color: Hexcolor('#0B0080'),
//                                        fontSize: 15.0,
//                                        fontWeight: FontWeight.bold),
//                                    textAlign: TextAlign.center,
//                                  ),
//                                ),
                              ],
                            ),
                          ],
                        )),

                    Divider(
                      height: 10,
                      color: Colors.white,
                      thickness: 1,
                    ),
                    SizedBox(height: 30),
//                    Text(
//                      'לצורך מציאת המאמן המושלם בשבילך נשמח אם תספר לנו עוד על עצמך',
//                      style: TextStyle(
//                          fontSize: 15.0, fontWeight: FontWeight.w300,color:Colors.white),
//                      textAlign: TextAlign.right,
//                    ),
                    TextFormFieldWidget(
                        validator: _validator,
                        currentText: widget.user.userName == null
                            ? ""
                            : widget.user.userName,
                        title: "שם",
                        type: "Name",
                        icon: FontAwesomeIcons.user,
                        onSave: (input) {
                          setState(() {
                            _name = input;
                            widget.user.userName = _name;
                          });
                        }),
                    Divider(
                      height: 5.0,
                      thickness: 2,
                      color: Colors.white,
                      endIndent: 10,
                      indent: 10,
                    ),

                    TextFormFieldWidget(
                        validator: _validator,
                        currentText: widget.user.workoutCity == null
                            ? ""
                            : widget.user.workoutCity,
                        type: "City",
                        title: "עיר אימונים",
                        icon: FontAwesomeIcons.city,
                        onSave: (input) {
                          setState(() {
                            _city = input;
                            widget.user.workoutCity = _city;
                          });
                        }),
                    Divider(
                      height: 5.0,
                      thickness: 2,
                      color: Colors.white,
                      endIndent: 10,
                      indent: 10,
                    ),

                    TextFormFieldWidget(
                        validator: _validator,
                        type: "PhoneNumber",
                        title: "מספר טלפון",
                        icon: FontAwesomeIcons.phone,
                        onSave: (input) {
                          setState(() {
                            _phoneNumber = input;
                            widget.user.phoneNumber = _phoneNumber;
                          });
                        }),
                    Divider(
                      height: 5.0,
                      thickness: 2,
                      color: Colors.white,
                      endIndent: 10,
                      indent: 10,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "בחר תאריך לידה",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
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
                          initialDateTime: widget.user.birthDate == null
                              ? new DateTime(1998, 5, 12)
                              : widget.user.birthDate,
                          backgroundColor: Hexcolor('#192841'),
                          onDateTimeChanged: (DateTime newdate) {
                            widget.user.birthDate = newdate;
                          },
                          use24hFormat: true,
                          minimumYear: 1900,
                          maximumYear: 2015,
                          minuteInterval: 1,
                          mode: CupertinoDatePickerMode.date,
                        )),
                    Text(
                      'בחר מגדר ורמה ספורטיבית',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
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
                          print(widget.user.birthDate);
//
//                          if (_phoneNumber == null ||
//                              widget.user.level == null ||
//                              _name == null ||
//                              _city == null ||
//                              _phoneNumber == "" ||
//                              widget.user.level == "" ||
//                              _name == "" ||
//                              _city == "") {
//                            print("username: " + widget.user.userName);
//                            print(_name);
//                            print("phone number: " + widget.user.phoneNumber);
//                            print(_name);
//
//                            print("level: " + widget.user.level);
//                            print(_level);
//
//                            print("city: " + widget.user.workoutCity);
//                            print(_city);
//                            // DISPLAY INFORMATION NEEDED
//                            print("NO GOOD");
//                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterSecondPage(), //ProfileScreen(user: user),
                                ));
//                          }
                        },
                        child: Text('המשך'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
