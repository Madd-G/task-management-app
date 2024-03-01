import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/entities/business_profile.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
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
                    const SizedBox(height: 30.0),
                    // netImageCached(data.businessLogo!, width: 150.0, height: 150.0),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120.0,
                          height: 120.0,
                          margin: const EdgeInsets.only(top: 0.0, bottom: 50.0),
                          decoration: BoxDecoration(
                            color: AppColor.scaffoldBackground,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(60.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: data.businessLogo == null
                              ? const Image(
                                  width: 150.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/account_header.png"))
                              : netImageCached(data.businessLogo!,
                                  width: 150.0, height: 150.0),
                        ),
                        Positioned(
                          bottom: 50.0,
                          right: 0.0,
                          height: 35.0,
                          child: GestureDetector(
                            child: Container(
                              height: 35.0,
                              width: 35.0,
                              padding: const EdgeInsets.all(7.0),
                              decoration: const BoxDecoration(
                                color: AppColor.accentColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              // child: Image.asset(
                              //   MediaRes.edit,
                              // ),
                            ),
                            onTap: () {
                              _showPicker(context);
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    BusinessName(data: data),
                    const SizedBox(height: 20.0),
                    ProfileBadge(data: data),
                    const SizedBox(height: 10.0),
                    Text(data.businessValue!, textAlign: TextAlign.justify),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  controller.imgFromGallery();
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  controller.imgFromCamera();
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
