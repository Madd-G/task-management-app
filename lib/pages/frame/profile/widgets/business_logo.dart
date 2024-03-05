import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
import 'package:konek_mobile/pages/frame/profile/controller.dart';

class BusinessLogo extends GetView<ProfileController> {
  const BusinessLogo({super.key, required this.data});

  final BusinessProfile data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          margin: const EdgeInsets.only(top: 0.0, bottom: 50.0),
          decoration: BoxDecoration(
            color: AppColor.scaffoldBackground,
            borderRadius: const BorderRadius.all(Radius.circular(60.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: netImageCached(
            data.businessLogo == null
                ? "https://static.vecteezy.com/system/resources/thumbnails/002/387/693/small/user-profile-icon-free-vector.jpg"
                : data.businessLogo!,
            width: 150.0,
            height: 150.0,
          ),
        ),
        Positioned(
          bottom: 50.0,
          right: 0.0,
          height: 35.0,
          child: GestureDetector(
            child: Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                color: AppColor.baseWhite,
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
              ),
              child: const Center(
                  child: Icon(
                Icons.camera_alt,
                size: 20.0,
              )),
            ),
            onTap: () {
              _showPicker(context);
            },
          ),
        )
      ],
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
                    Navigator.pop(bc);
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  controller.imgFromCamera();
                  Navigator.pop(bc);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
