class User {
  final String id;
  final String name;
  final String email;
  final String rfc;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.rfc,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      rfc: json['rfc'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'rfc': rfc,
    };
  }
}
