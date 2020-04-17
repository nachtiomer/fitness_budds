import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final Color backgroundColor = Colors.teal;

class RegisterSecondPage extends StatefulWidget {
  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage>
    with SingleTickerProviderStateMixin {
  int _selectedGender = 0;
  List<int> _selected = [0, 0, 0, 0, 0, 0, 0, 0];
  double screenWidth, screenHeight;
  double val = 2.0;
  double valPrice =2.0;
  double valAvailability =2.0;
  double valRecommendation =2.0;
  double valExperience =2.0;

  bool _isVisible = false;

  List<IconData> _gender = [FontAwesomeIcons.male, FontAwesomeIcons.female];

  List<IconData> _icons = [
    FontAwesomeIcons.running,
    FontAwesomeIcons.users,
    FontAwesomeIcons.dumbbell,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.accessibleIcon,
    FontAwesomeIcons.futbol,
    FontAwesomeIcons.swimmer,
    FontAwesomeIcons.plus
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(backgroundColor: backgroundColor, body: SecondPage());
  }

  Widget _buildIcon(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (_selected[index] == index) {
              _selected[index] = null;
            } else {
              _selected[index] = index;
            }
          });
        },
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
              color: _selected[index] == index ? Colors.teal : Colors.grey,
              borderRadius: BorderRadius.circular(30)),
          child: Icon(_icons[index],
              size: 25.0,
              color: _selected[index] == index
                  ? Colors.black
                  : Colors.black54), //Theme.of(context).primaryColor),
        ));
  }

  Widget _buildSlider(String title) {
    if(title == "מחיר"){
      val = valPrice;
    }else if(title == "זמינות"){
      val = valAvailability;
    }else if(title == "ניסיון"){
      val = valExperience;
    }else if(title == "ביקורות"){
      val = valRecommendation;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 5.0, right: 10.0),
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
              child: Slider(
                  value: val,
                  onChanged: (double e) => setState(() {
                    val = e;
                  }),
                  activeColor: Colors.teal,
                  inactiveColor: Colors.grey,
                  label: title,
                  max: 10.0,
                  min: 1.0),
            ),
          ],
        ),
      ],
    );
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


  Widget SecondPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Text("מציאת המאמן המושלם",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),),
            Text(
              "סמן פעילויות מועדפות",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: _icons
                  .asMap()
                  .entries
                  .map((MapEntry map) => _buildIcon(map.key))
                  .toList()
                  .sublist(0, 4),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            SizedBox(height: 10.0),
            Row(
              children: _icons
                  .asMap()
                  .entries
                  .map((MapEntry map) => _buildIcon(map.key))
                  .toList()
                  .sublist(4),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            SizedBox(height: 20.0),
            RaisedButton(
                onPressed: () {
                  setState(() {
                    _isVisible =!_isVisible;
                  });
                },
                child: Text('חשוב לי מין המאמן')),
            Visibility(
              child:Row(
                children: _gender
                    .asMap()
                    .entries
                    .map((MapEntry map) => _buildGenderIcon(map.key))
                    .toList(),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              visible: _isVisible,
            ),
            SizedBox(height: 20.0,),
            Text(
              "סדר לפי חשיבות ",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3), // Change Position of shadow
                        )
                      ]),
                      child: _buildSlider("מחיר")),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3), // Change Position of shadow
                        )
                      ]),
                      child: _buildSlider("זמינות")),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3), // Change Position of shadow
                        )
                      ]),
                      child: _buildSlider("ניסיון")),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3), // Change Position of shadow
                        )
                      ]),
                      child: _buildSlider("ביקורות")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
