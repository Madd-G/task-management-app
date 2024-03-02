import 'package:cloud_firestore/cloud_firestore.dart';

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
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'weight': weight,
      'description': description,
      'start_date': _formatDateTime(startDate),
      'end_date': _formatDateTime(endDate),
      'status': status,
      'assignee': assignee,
      'target': target,
      'progress': progress,
      'priority': priority,
      'created_at': _formatDateTime(createdAt),
      'updated_at': _formatDateTime(updatedAt),
    };
  }

  Map<String, dynamic> toJsonProgress() {
    return {
      'id': id,
      'progress': progress,
    };
  }

  Map<String, dynamic> toJsonStatus() {
    return {
      'id': id,
      'status': status,
    };
  }

  Map<String, dynamic> toJsonPriority() {
    return {
      'id': id,
      'priority': priority,
    };
  }

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
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
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, name: $name, category: $category, weight: $weight, '
        'description: $description, startDate: $startDate, endDate: $endDate, '
        'status: $status, assignee: $assignee, target: $target, progress: $progress, '
        'priority: $priority, createdAt: $createdAt, updatedAt: $updatedAt)';
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
