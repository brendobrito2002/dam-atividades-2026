class UserProfileModel {
  final String username;
  final String email;
  final String password;

  UserProfileModel({
    required this.username,
    required this.email,
    required this.password,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "id": 1, // Mantém fixo em 1 para garantir apenas um registro de perfil
    "username": username,
    "email": email,
    "password": password,
  };

  @override
  String toString() {
    return 'UserProfileModel{username: $username, email: $email}';
  }
}
