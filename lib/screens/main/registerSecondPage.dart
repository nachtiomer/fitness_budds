import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final Color backgroundColor = Colors.teal;

class WorkoutCategory {
  bool selected;
  IconData icon;
  WorkoutCategory({this.icon, this.selected});

  WorkoutCategory.initial(IconData icon) {
    this.icon = icon;
    this.selected = false;
  }
}

class PrioritySlider {
  double value;
  String title;

  PrioritySlider({this.value, this.title});

  PrioritySlider.initial(String title) {
    this.value = 2.0;
    this.title = title;
  }
}

class RegisterSecondPage extends StatefulWidget {
  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage>
    with SingleTickerProviderStateMixin {
  int _selectedGender = 0;
  final Map<String, WorkoutCategory> _categories = {
    'running': WorkoutCategory.initial(FontAwesomeIcons.running),
    'groups': WorkoutCategory.initial(FontAwesomeIcons.users),
    'power': WorkoutCategory.initial(FontAwesomeIcons.dumbbell),
    'meditation': WorkoutCategory.initial(FontAwesomeIcons.bed),
    'disabled': WorkoutCategory.initial(FontAwesomeIcons.accessibleIcon),
    'football': WorkoutCategory.initial(FontAwesomeIcons.futbol),
    'swimming': WorkoutCategory.initial(FontAwesomeIcons.swimmer)
  };
  double screenWidth, screenHeight;
  Map<String, PrioritySlider> _sliders = {
    'price': PrioritySlider.initial('מחיר'),
    'availability': PrioritySlider.initial('זמינות'),
    'recommendation': PrioritySlider.initial('המלצות'),
    'expirience': PrioritySlider.initial('נסיון'),
    'distance': PrioritySlider.initial('מרחק')
  };

  bool _isTrainerGenderVisible = false;

  List<IconData> _gender = [FontAwesomeIcons.male, FontAwesomeIcons.female];

  Widget _buildIcon(String key) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _categories[key].selected = !_categories[key].selected;
          });
        },
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
              color: _categories[key].selected ? Colors.teal : Colors.grey,
              borderRadius: BorderRadius.circular(30)),
          child: Icon(_categories[key].icon,
              size: 25.0,
              color: _categories[key].selected
                  ? Colors.black
                  : Colors.black54), //Theme.of(context).primaryColor),
        ));
  }

  Widget _buildSlider(String key) {
    PrioritySlider slider = _sliders[key];
    return Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // Change Position of shadow
              )
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5.0, right: 10.0),
                  child: Text(
                    slider.title,
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
                          value: slider.value,
                          onChanged: (double e) => setState(() {
                                slider.value = e;
                              }),
                          activeColor: Colors.teal,
                          inactiveColor: Colors.grey,
                          label: slider.title,
                          max: 10.0,
                          min: 1.0),
                    ),
                  ],
                ),
              ],
            )));
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Text(
              "מציאת המאמן המושלם",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              children: _categories.keys.take(4).map(_buildIcon),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            SizedBox(height: 10.0),
            Row(
              children: _categories.keys.skip(4).map(_buildIcon),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            SizedBox(height: 20.0),
            RaisedButton(
                onPressed: () {
                  setState(() {
                    _isTrainerGenderVisible = !_isTrainerGenderVisible;
                  });
                },
                child: Text('חשוב לי מין המאמן')),
            Visibility(
              child: Row(
                children: _gender
                    .asMap()
                    .entries
                    .map((MapEntry map) => _buildGenderIcon(map.key))
                    .toList(),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              visible: _isTrainerGenderVisible,
            ),
            SizedBox(
              height: 20.0,
            ),
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
                children: _sliders.keys.map(_buildSlider)),
          ],
        ),
      ),
    );
  }
}
