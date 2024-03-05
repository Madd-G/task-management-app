import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/entities/business_profile.dart';
import 'package:konek_mobile/pages/frame/profile/controller.dart';
import 'package:konek_mobile/pages/frame/profile/widgets/widgets.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('business_profile')
                  .doc('konek')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
                final dataResponse =
                    snapshot.data!.data() as Map<String, dynamic>;
                BusinessProfile data = BusinessProfile.fromJson(dataResponse);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            controller.goLogout();
                            controller.deleteDeviceToken();
                          },
                          icon: const Icon(Icons.logout)),
                    ),
                   BusinessLogo(data: data),
                    const SizedBox(height: 20.0),
                    BusinessName(data: data),
                    const SizedBox(height: 20.0),
                    ProfileBadge(data: data),
                    const SizedBox(height: 10.0),
                    BusinessValue(data: data),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

}

