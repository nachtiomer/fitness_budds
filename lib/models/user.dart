import './providerDetails.dart';

class User{

  final String uid;
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  User(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData, [this.uid]);
}
