class Token {
  final String username;
  final String value;

  Token({
    required this.username,
    required this.value,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      username: json['username'],
      value: json['token'],
    );
  }
}
