class User {
  final int? id;
  final String? name;
  final String? email;
  final String username;
  final String? password;

  const User(
      {this.id, this.name, this.email, required this.username, this.password});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['first_name'],
        email: json['email'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        'first_name': name,
        'email': email,
        'username': username,
        'password': password,
      };
}
