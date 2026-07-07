// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserProfile {
  UserProfile({
    required this.username,
    required this.recoveryEmail,
    required this.password,
  });

  String username;
  String recoveryEmail;
  String password;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        username: json["username"],
        recoveryEmail: json["recovery_email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": 1,
        "username": username,
        "recovery_email": recoveryEmail,
        "password": password,
      };
}