


class User {
  User(
      {this.id,
      required this.name,
      required this.username,
      this.email,
      this.isAdmin,
      this.isStaff});
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final bool? isAdmin;
  final bool? isStaff;

  factory User.empty() => User(
      id: null,
      name: '',
      username: '',
      email: '',
      isAdmin: null,
      isStaff: null);

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        name: json["name"],
        isAdmin: json["isAdmin"],
        isStaff: json["isStaff"],
      );
}
