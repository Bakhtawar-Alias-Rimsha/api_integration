class RandomUser {
  final String fullName;
  final String email;
  final String avatarUrl;

  RandomUser({
    required this.fullName,
    required this.email,
    required this.avatarUrl,
  });

  // randomuser.me structure → { results: [ { name: {first,last}, email, picture: {large} } ] }
  factory RandomUser.fromApi(Map<String, dynamic> json) {
    final result = (json['results'] as List).first;
    final name = result['name'];
    final picture = result['picture'];

    final full = '${name['first']} ${name['last']}';
    return RandomUser(
      fullName: full,
      email: result['email'],
      avatarUrl: picture['large'],
    );
  }
}
