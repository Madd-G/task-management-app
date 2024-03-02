import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/widgets/rounded_container.dart';
import 'package:konek_mobile/pages/frame/profile/index.dart';

class ProfileBadge extends GetView<ProfileController> {
  const ProfileBadge({super.key, required this.data});

  final BusinessProfile data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 50.0,
          width: size.width * 0.75,
          child: ListView.builder(
            itemCount: data.businessSector!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, right: 12.0, bottom: 8.0),
                child: GestureDetector(
                  onDoubleTap: () {
                    UserStore.to.profile.role == "owner"
                        ? BusinessProfileAPI.deleteBusinessSector(index: index)
                        : null;
                  },
                  child: RoundedContainer(
                      containerColor: Colors.green,
                      radius: 6.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 8.0),
                        child: Text(data.businessSector![index]),
                      )),
                ),
              );
            },
          ),
        ),
        if (UserStore.to.profile.role == "owner" &&
            data.businessSector!.length < 3)
          GestureDetector(
            onTap: () {
              openDialog(context, controller);
            },
            child: RoundedContainer(
              containerColor: Colors.green.withOpacity(0.5),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.add),
              ),
            ),
          )
      ],
    );
  }

  Future<String?> openDialog(
      BuildContext context, ProfileController controller) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Add business sector'),
          content: TextField(
            autofocus: true,
            controller: controller.sectorController,
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  BusinessProfile profile = BusinessProfile();
                  profile.singleSector = controller.sectorController.text;
                  controller.sectorController.clear();
                  BusinessProfileAPI.addBusinessSector(profile);
                  Get.back();
                },
                child: const Text('SAVE'))
          ],
        );
      },
    );
  }
}
