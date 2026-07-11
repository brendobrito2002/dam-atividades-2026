// ignore_for_file: public_member_api_docs, sort_constructors_first
class PasswordModel {
  PasswordModel({
    required this.serviceName,
    required this.username,
    required this.password,
  });

  String serviceName;
  String username;
  String password;

  factory PasswordModel.fromJson(Map<String, dynamic> json) => PasswordModel(
        serviceName: json["service_name"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "username": username,
        "password": password,
      };
}
