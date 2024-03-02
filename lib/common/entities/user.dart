class UserEntity {
  String? id;
  String? username;
  String? email;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? password;
  String? token;

  UserEntity({
    this.id,
    this.username,
    this.email,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.password,
    this.token,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json["id"],
      username: json["username"],
      email: json["email"] ?? '',
      role: json["role"],
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
      token: json["token"],
    );
  }

  factory UserEntity.fromJsonResponse(Map<String, dynamic> json) {
    var userData = json['userData'];
    if (userData != null) {
      return UserEntity.fromJson(userData);
    } else {
      throw Exception("User data is null");
    }
  }

  Map<String, dynamic> toJsonRequest() => {
        "id": id,
        "password": password,
      };

  Map<String, dynamic> toJsonUpdateDeviceToken() => {
        "id": id,
        "token": token,
      };

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "password": password,
      "email": email,
      "role": role,
      "createdAt": _formatDateTime(createdAt),
      "updatedAt": _formatDateTime(updatedAt),
      "token": token,
    };
  }

  static DateTime? _parseDateTime(dynamic dateTime) {
    if (dateTime == null) {
      return null;
    }

    if (dateTime is Map<String, dynamic> &&
        dateTime.containsKey('_seconds') &&
        dateTime['_seconds'] is int) {
      return DateTime.fromMillisecondsSinceEpoch(
        (dateTime['_seconds'] as int) * 1000,
      );
    }

    return null;
  }

  static Map<String, dynamic> _formatDateTime(DateTime? dateTime) =>
      dateTime != null
          ? {
              "_seconds": dateTime.millisecondsSinceEpoch ~/ 1000,
              "_nanoseconds":
                  (dateTime.microsecondsSinceEpoch % 1000000) * 1000,
            }
          : {};
}
