class User {
  final int? id;
  final String? email;
  final String? full_name;
  final String? password;
  final String? company;
  final String? phone_number;
  final int? role_id;
  final String? type;
  String? token;

  User(
      {this.email, this.full_name, this.company, this.phone_number, this.role_id, this.id, this.password, this.type, this.token});
  String? get getToken => token;

  set setToken(String token) {
    token = token;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      full_name: json["full_name"],
      email: json["email"],
      company: json["company"],
      phone_number: json["phone_number"],
      role_id: json["role_id"],
      type: json["type"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": full_name,
        "email": email,
        "company": company,
        "phone_number": phone_number,
        "password": password,
        "role_id": role_id,
        "type": type,
        "token": token,
      };
}
