import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String? name;
  String? category;
  num? weight;
  DateTime? startDate;
  DateTime? endDate;
  String? status;
  String? assignee;
  String? target;

  // final DateTime createdAt;
  // final DateTime updatedAt;

  Task({
    this.id,
    this.name,
    this.category,
    this.weight,
    this.startDate,
    this.endDate,
    this.status,
    this.assignee,
    this.target,
    // required this.createdAt,
    // required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'weight': weight,
      'start_date': _formatDateTime(startDate),
      'end_date': _formatDateTime(endDate),
      'status': status,
      'assignee': assignee,
      'target': target
    };
  }

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Task(
      id: data['id'],
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      weight: data['weight'] ?? 0,
      startDate: (data['start_date'] as Timestamp).toDate(),
      endDate: (data['end_date'] as Timestamp).toDate(),
      status: data['status'] ?? '',
      assignee: data['assignee'] ?? '',
      target: data['target'] ?? '',
      // createdAt: (data['created_at'] as Timestamp).toDate(),
      // updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
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
