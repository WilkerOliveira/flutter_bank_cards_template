import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userID;
  String firstName;
  String email;
  String profilePictureURL;
  String password;
  String nickName;
  String confirmPassword;

  User({
    this.userID,
    this.firstName,
    this.email,
    this.profilePictureURL,
    this.nickName
  });

  Map<String, Object> toJson() {
    return {
      'userID': userID,
      'firstName': firstName,
      'email': email == null ? '' : email,
      'profilePictureURL': profilePictureURL,
      'nickName': nickName,
      'appIdentifier': 'flutter-onboarding'
    };
  }

  factory User.fromJson(Map<String, Object> doc) {
    User user = new User(
      userID: doc['userID'],
      firstName: doc['firstName'],
      nickName: doc['nickName'],
      email: doc['email'],
      profilePictureURL: doc['profilePictureURL'],
    );
    return user;
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}
