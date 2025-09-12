class UserModel {
  final String id;
  final String name;
  final String? email;

  UserModel({required this.id, required this.name, this.email});

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'] as String,
        name: map['name'] as String,
        email: map['email'] as String?,
      );
}
