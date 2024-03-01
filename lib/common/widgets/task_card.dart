import 'package:flutter/material.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';

class TaskCard extends StatelessWidget {
  final Task product;

  const TaskCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${product.category}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Weight: ${product.weight}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Start Date: ${product.startDate!.toDate()}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'End Date: ${product.endDate!.toDate()}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Status: ${product.status}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}