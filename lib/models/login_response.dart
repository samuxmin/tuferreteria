class LoginResponse {
  bool logged;
  String token;
  bool isAdmin;

  LoginResponse({required this.logged,required this.token, required this.isAdmin});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      logged: json['logged'],
      token: json['token'],
      isAdmin: json['isAdmin'],
    );
  }
}