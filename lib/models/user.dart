import './providerDetails.dart';

class User {
  String genderPreference;
  String providerDetails;
  String userName;
  String photoUrl;
  String userEmail;
  DateTime birthDate;
  String gender;
  String level;
  String age;
  String workoutCity;
  String phoneNumber;
  List<String> friendsList;
  List<String> perfectTrainers;
  List<String> activityPreference;
  List<ProviderDetails> providerData;

  User(
      this.genderPreference,
      this.providerDetails,
      this.userName,
      this.photoUrl,
      this.userEmail,
      this.birthDate,
      this.level,
      this.age,
      this.workoutCity,
      this.phoneNumber,
      this.friendsList,
      this.activityPreference,
      this.providerData,
      this.perfectTrainers,
      this.gender);
}
