import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:konek_mobile/common/utils/format_date_time.dart';

class Task {
  String? id;
  String? name;
  String? category;
  num? weight;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? status;
  String? assignee;
  String? target;
  num? progress;
  String? priority;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isRead;
  String? updater;
  List<Message>? messages;
  Message? message;
  String? imageUrl;
  bool? isNotificationSent;

  Task({
    this.id,
    this.name,
    this.category,
    this.weight,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.assignee,
    this.target,
    this.progress,
    this.priority,
    this.createdAt,
    this.updatedAt,
    this.isRead,
    this.updater,
    this.messages,
    this.message,
    this.imageUrl,
    this.isNotificationSent,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'weight': weight,
      'description': description,
      'start_date': FormatDateTime.formatDateTime(startDate),
      'end_date': FormatDateTime.formatDateTime(endDate),
      'status': status,
      'assignee': assignee,
      'target': target,
      'progress': progress,
      'priority': priority,
      'created_at': FormatDateTime.formatDateTime(createdAt),
      'updated_at': FormatDateTime.formatDateTime(updatedAt),
      'is_read': isRead,
      'updater': updater,
      'image_url': imageUrl,
      'is_notification_sent': isNotificationSent,
    };
  }

  Map<String, dynamic> toJsonProgress() {
    return {
      'id': id,
      'progress': progress,
      'updater': updater,
    };
  }

  Map<String, dynamic> toJsonStatus() {
    return {
      'id': id,
      'status': status,
      'updater': updater,
    };
  }

  Map<String, dynamic> toJsonPriority() {
    return {
      'id': id,
      'priority': priority,
      'updater': updater,
    };
  }

  Map<String, dynamic> toJsonDeadline() {
    return {
      'id': id,
      'end_date': endDate,
      'updater': updater,
    };
  }

  Map<String, dynamic> toJsonMessage() {
    return {
      'id': id,
      'messages': message,
      'updater': updater,
    };
  }

  Map<String, dynamic> toJsonIsRead() {
    return {
      'id': id,
      'is_read': isRead,
    };
  }

  Map<String, dynamic> toJsonNotificationSent() {
    return {
      'id': id,
      'is_notification_sent': isNotificationSent,
    };
  }

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    List<dynamic> messagesData = data['messages'] ?? [];

    List<Message> messages = messagesData.map((messageData) {
      return Message(
        message: messageData['message'],
        sender: messageData['sender'] ?? '',
        time: (messageData['time'] as Timestamp).toDate(),
      );
    }).toList();
    return Task(
        id: data['id'],
        name: data['name'] ?? '',
        category: data['category'] ?? '',
        weight: data['weight'] ?? 0,
        description: data['description'] ?? '',
        startDate: (data['start_date'] as Timestamp).toDate(),
        endDate: (data['end_date'] as Timestamp).toDate(),
        status: data['status'] ?? '',
        assignee: data['assignee'] ?? '',
        target: data['target'] ?? '',
        progress: data['progress'] ?? 0,
        priority: data['priority'] ?? '',
        createdAt: (data['created_at'] as Timestamp).toDate(),
        updatedAt: (data['updated_at'] as Timestamp).toDate(),
        isRead: data['is_read'],
        updater: data['updater'] ?? '',
        messages: messages,
        imageUrl: data['image_url'] ?? '',
        isNotificationSent: data['is_notification_sent']);
  }

  @override
  String toString() {
    return 'Task(id: $id, name: $name, category: $category, weight: $weight, '
        'description: $description, startDate: $startDate, endDate: $endDate, '
        'status: $status, assignee: $assignee, target: $target, progress: $progress, '
        'priority: $priority, createdAt: $createdAt, updatedAt: $updatedAt, '
        'isRead: $isRead, updater: $updater, imageUrl: $imageUrl, '
        'isNotificationSent: $isNotificationSent)';
  }
}

class Message {
  String? message;
  String? sender;
  DateTime? time;

  Message({this.message, this.sender, this.time});

  factory Message.fromMap(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Message(
      message: data['message'],
      sender: data['sender'] ?? '',
      time: (data['time'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
    };
  }
}
