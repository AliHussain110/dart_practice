class UserProfile {
  final int id;
  final String name;
  final String email;
  final int age;
  UserProfile(this.id, this.name, this.email, this.age);

  UserProfile copyWith(int? id, String? name, String? email, int? age) {
    return UserProfile(
      id ?? this.id,
      name ?? this.name,
      email ?? this.email,
      age ?? this.age,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null ||
        json['name'] == null ||
        json['email'] == null ||
        json['age'] == null ||
        json['age'] < 18) {
      throw InvalidProfileDataException(message: 'Invalid User Data');
    }
    return UserProfile(
      json['id'] as int,
      json['name'] as String,
      json['email'] as String,
      json['age'] as int,
    );
  }
}

Future<List<UserProfile>> processUserData(
  List<Map<String, dynamic>> rawData,
) async {
  final List<UserProfile> users = [];
  //       print('hello');
  rawData.forEach((u) {
    try {
      var user = UserProfile.fromJson(u);
      users.add(user);
    } on InvalidProfileDataException catch (e) {
      print(e);
    }
  });
  //       print('hello');
  //     user.forEach((e)=> print(e?.name));

  return users;
}

class InvalidProfileDataException implements Exception {
  final String message;
  InvalidProfileDataException({required this.message});
  @override
  String toString() {
    return message;
  }
}

void main() async {
  final List<Map<String, dynamic>> mockApiData = [
    {'id': 1, 'name': 'Alice', 'email': 'alice@example.com', 'age': 30},
    {'id': 2, 'name': 'Bob'}, // Missing email and age
    {
      'id': 3,
      'name': 'Charlie',
      'email': 'charlie@example.com',
      'age': 17,
    }, // Too young
    {'id': 4, 'name': 'David', 'email': 'david@example.com', 'age': 45},
    {
      'id': null,
      'name': 'Eve',
      'email': 'eve@example.com',
      'age': 25,
    }, // Missing id
  ];

  List<UserProfile> validProfiles = await processUserData(mockApiData);
  print('Processing complete. Valid profiles found:${validProfiles.length}');
  // Expected output should indicate 2 valid profiles (Alice and David).
}
