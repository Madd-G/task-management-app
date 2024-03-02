import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key, required this.data});

  final Task data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<void> showAlertDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Task'),
            backgroundColor: Colors.white,
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure want to delete task?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  TaskAPI.deleteTask(docId: data.id!);
                  Get.back();
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width,
          color: const Color(0XFF74C4A9),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 24.0, top: 24.0, right: 24.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundedContainer(
                          containerColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                                onTap: () => Get.back(),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 18.0,
                                )),
                          ),
                        ),
                        if (UserStore.to.profile.role == "owner")
                          GestureDetector(
                            onTap: showAlertDialog,
                            child: RoundedContainer(
                              radius: 10.0,
                              containerColor: AppColor.baseWhite,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3.0, horizontal: 6.0),
                                child: Text(
                                  'DELETE',
                                  style: CustomTextStyle.textSmallBold
                                      .copyWith(color: Colors.pink),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      data.name!,
                      style: CustomTextStyle.text3ExtraLargeRegular
                          .copyWith(color: Colors.black),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.watch_later_outlined),
                        const SizedBox(width: 6.0),
                        Text(
                          data.endDate!.toDate(),
                          style: CustomTextStyle.textRegularSemiBold,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          '(${DateTime.now().differenceDate(data.endDate!)} left)',
                          style: CustomTextStyle.textRegular,
                        ),
                      ],
                    ),
                    if (UserStore.to.profile.role == "owner")
                      Text("Assignee: ${data.assignee!}",
                          style: CustomTextStyle.textRegular),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
