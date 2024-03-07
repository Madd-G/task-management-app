import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/business_profile.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/pages/frame/profile/controller.dart';

class BusinessName extends StatefulWidget {
  const BusinessName({super.key, required this.data});

  final BusinessProfile data;

  @override
  State<BusinessName> createState() => _BusinessNameState();
}

class _BusinessNameState extends State<BusinessName> {
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.data.businessName);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => GestureDetector(
        onTap: UserStore.to.profile.role == 'owner'
            ? () async {
                final name = await openDialog(context, controller);
                if (name == null || name.isEmpty) return;
              }
            : () {},
        child: Text(widget.data.businessName!,
            style: CustomTextStyle.text2ExtraLargeSemiBold, maxLines: 2),
      ),
    );
  }

  Future<String?> openDialog(
      BuildContext context, ProfileController controller) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Update Business Name'),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: TextField(
            autofocus: true,
            controller: nameController,
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  BusinessProfile profile = BusinessProfile();
                  profile.businessName = nameController.text;
                  BusinessProfileAPI.updateName(profile);
                  Get.back();
                },
                child: const Text('SAVE'))
          ],
        );
      },
    );
  }
}
