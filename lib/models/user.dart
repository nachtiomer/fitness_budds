import './providerDetails.dart';

class User{
  final String genderPreference;
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final String birthDate;
  final String gender;
  final String level;
  final String age;
  final List<String> mainCities;
  final List<String> friendsList;
  final List<String> perfectTrainers;
  final List<String> activityPreference;
  final List<ProviderDetails> providerData;

  User(this.genderPreference, this.providerDetails, this.userName,
      this.photoUrl, this.userEmail, this.birthDate, this.level, this.age,
      this.mainCities, this.friendsList, this.activityPreference,
      this.providerData, this.perfectTrainers, this.gender);

}

