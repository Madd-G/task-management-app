import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/pages/frame/profile/index.dart';

class BusinessValue extends StatefulWidget {
  const BusinessValue({super.key, required this.data});

  final BusinessProfile data;

  @override
  State<BusinessValue> createState() => _BusinessValueState();
}

class _BusinessValueState extends State<BusinessValue> {
  late TextEditingController valueController;

  @override
  void initState() {
    valueController = TextEditingController(text: widget.data.businessValue);
    super.initState();
  }

  @override
  void dispose() {
    valueController.dispose();
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
        child: Text(
          widget.data.businessValue!,
        ),
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
          content: TextField(
            maxLines: 10,
            autofocus: true,
            controller: valueController,
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  BusinessProfile profile = BusinessProfile();
                  profile.businessValue = valueController.text;
                  BusinessProfileAPI.updateValue(profile);
                  Get.back();
                },
                child: const Text('SAVE'))
          ],
        );
      },
    );
  }
}
