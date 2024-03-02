class NotificationEntity {
  NotificationDetail? notification;
  String? token;

  NotificationEntity({
    this.notification,
    this.token,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      notification: NotificationDetail.fromJson(json['notification']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'notification': notification?.toJson(),
      'token': token,
    };
    return data;
  }
}

class NotificationDetail {
  final String title;
  final String body;

  NotificationDetail({
    required this.title,
    required this.body,
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
    return NotificationDetail(
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'title': title,
      'body': body,
    };
    return data;
  }
}
