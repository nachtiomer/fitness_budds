import 'package:fitnessbudds/models/coach.dart';
import 'package:flutter/material.dart';

class CoachesScreen extends StatefulWidget {

  @override
  _CoachesScreenState createState() => _CoachesScreenState();
}

class _CoachesScreenState extends State<CoachesScreen>  {
  final COACHES = [
    Coach(
        'Daniel',
        'https://daniel-t.co.il/wp-content/uploads/2016/12/Personal-fitness-trainer-in-Rishon-Letzion.jpg',
        'Haifa',
        'Never give up'
    ),
    Coach(
        'Dor',
        'https://static.vecteezy.com/system/resources/previews/000/153/703/non_2x/free-personal-trainer-illustration-vector.jpg',
        'Naharia',
        'No pain no gain!'
    )
  ];

  List<Coach> coaches= List<Coach>();
  TextEditingController controller = new TextEditingController();
  String filter;

  bool isCoachVisible(coach,filter) {
    return filter == null || filter == "" || coach.displayname.toLowerCase().contains(filter.toLowerCase());
  }

  @override
  initState() {
    for (var i=0;i<COACHES.length;i++) {
      coaches.add(COACHES[i]);
    }
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(
              hintText: 'search coaches',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
              ),
              contentPadding: const EdgeInsets.all(20.0)
            ),
            controller: controller,
          ),
        ),
        body: Center(
          child: new ListView.builder(
            itemCount: coaches.length,
            itemBuilder: (BuildContext context, int index) {
              var coach = coaches[index];
              return isCoachVisible(coach, filter) ? new ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(coach.photoUrl),
                  radius: 50.0,
                ),
                title: Text(coach.displayname),
              ): new Container();
            }
          )
        ));
  }
}