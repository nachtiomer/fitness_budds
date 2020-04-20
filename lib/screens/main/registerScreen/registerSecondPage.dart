import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitnessbudds/screens/main/registerScreen/addActivityPage.dart';

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
  List<String> activityPreference;
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
    'price': PrioritySlider.initial('מחיר נמוך'),
    'availability': PrioritySlider.initial('זמינות גבוהה'),
    'recommendation': PrioritySlider.initial('ביקורות טובות'),
    'expirience': PrioritySlider.initial('נסיון מרובה'),
    'distance': PrioritySlider.initial('מרחק קטן')
  };

  bool _isTrainerGenderVisible = false;

  List<IconData> _gender = [FontAwesomeIcons.male, FontAwesomeIcons.female];

  Widget _buildIcon(String key) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _categories[key].selected = !_categories[key].selected;
//            activityPreference.contains(key) ? activityPreference.remove(key) : activityPreference.add(key);
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
            height: 80,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, left: 20.0),
                      child: Text(
                        slider.value.toInt().toString(),
                        // < 5 ? "לא חשוב" : "חשוב",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 10 + slider.value / 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 10.0),
                      child: Text(
                        slider.title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
              children: _categories.keys.take(4).map(_buildIcon).toList(),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            SizedBox(height: 10.0),
            Row(
              children: _categories.keys.skip(4).map(_buildIcon).toList(),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              heroTag: "11111",
              child: Icon(FontAwesomeIcons.plus),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddActivityPage(), //ProfileScreen(user: user),
                    ));
              },
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
                children: _sliders.keys.map(_buildSlider).toList()),
          ],
        ),
      ),
    );
  }
}
