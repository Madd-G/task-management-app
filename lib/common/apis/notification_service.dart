import 'dart:convert';

import 'package:dio/dio.dart';

class NotificationService {
  static const String baseUrl = 'https://us-central1-konek-mobile.cloudfunctions.net'; // Ganti dengan URL endpoint Cloud Functions Anda

  static Future<void> sendNotification(Map<String, dynamic> notificationData) async {
    final Dio dio = Dio();
    const String url = '$baseUrl/sendNotification';

    try {
      final Response response = await dio.post(
        url,
        data: jsonEncode(notificationData),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification. Error: ${response.data}');
      }
    } catch (error) {
      print('Failed to send notification. Error: $error');
    }
  }
}