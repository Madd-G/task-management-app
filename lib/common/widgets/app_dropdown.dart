// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:konek_mobile/common/style/style.dart';
// import 'package:konek_mobile/common/utils/utils.dart';
// import 'package:konek_mobile/common/widgets/widgets.dart';
// import 'package:konek_mobile/pages/frame/product/add_product_task_screen/index.dart';
//
// class StatusDropdown extends StatelessWidget {
//   const StatusDropdown({super.key, required this.status});
//
//   final RxString? status;
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return RoundedContainer(
//       height: 60.0,
//       radius: 5.0,
//       borderColor: Colors.grey,
//       containerColor: AppColor.scaffoldBackground,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SizedBox(
//           width: size.width,
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               padding: EdgeInsets.zero,
//               dropdownColor: Colors.white,
//               isDense: true,
//               icon: const Icon(
//                 Icons.keyboard_arrow_down,
//                 color: Colors.grey,
//                 size: 15.0,
//               ),
//               items: controller.state.statusList.map((val) {
//                 return DropdownMenuItem<String>(
//                   value: val['value'],
//                   child: Text(val['value']!),
//                 );
//               }).toList(),
//               hint: Row(
//                 children: <Widget>[
//                   const Icon(
//                     Icons.circle,
//                     color: Colors.red,
//                   ),
//                   const SizedBox(width: 15.0),
//                   Obx(
//                         () => Text(
//                       status!.value,
//                       style: CustomTextStyle.textRegular.copyWith(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               onChanged: (String? val) {
//                 status!.value = val!;
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
