class UserEntity {
  String? id;
  String? username;
  String? email;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? password;
  String? token;
  String? fcmToken;

  UserEntity({
    this.id,
    this.username,
    this.email,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.password,
    this.token,
    this.fcmToken,
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
      fcmToken: json["fcmToken"],
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
        "fcmToken": fcmToken,
      };

  Map<String, dynamic> toJsonDeleteDeviceToken() => {
        "id": id,
      };

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "password": password,
      "email": email,
      "role": role,
      "createdAt": _formatDateTime(createdAt!),
      "updatedAt": _formatDateTime(updatedAt!),
      "token": token,
      "fcmToken": fcmToken,
    };
  }

  static String _formatDateTime(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  static DateTime _parseDateTime(dynamic json) {
    return DateTime.parse(json);
  }
}
