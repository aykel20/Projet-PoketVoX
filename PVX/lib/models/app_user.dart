
class AppUser {
  final String id;
  final String name;
  final String pin;
  final DateTime createdAt;

  const AppUser({required this.id, required this.name, required this.pin, required this.createdAt});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'pin': pin,
    'createdAt': createdAt.toIso8601String(),
  };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    id: json['id'] as String,
    name: json['name'] as String,
    pin: json['pin'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}
