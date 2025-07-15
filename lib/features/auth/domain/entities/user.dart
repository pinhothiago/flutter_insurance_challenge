class User {
  final String id;
  final String name;
  final String email;
  final String? cpf;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.cpf,
  });

  static const empty = User(id: '', name: '', email: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;
}
