// import 'package:flutter/material.dart';
// import 'package:mydairy/export.dart';

// final addFarmer11Provider = StateProvider.autoDispose<int>((ref) => 0);

// class RadioAddCustomerValue3 extends ConsumerWidget {
//   const RadioAddCustomerValue3(
//       {super.key, required this.txt1, required this.txt2});
//   final String txt1;
//   final int txt2;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final addFarmerBuild = ref.watch(addFarmer11Provider);

//     return Padding(
//       padding: EdgeInsets.only(left: 17.w),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 7.w),
//             child: Text(
//               txt1,
//               style: TextStyle(fontSize: 18.w),
//             ),
//           ),
//           Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(
//                   2,
//                   (index) => Row(
//                         children: [
//                           Radio(
//                             activeColor: AppColor.appColor,
//                             value: index,
//                             groupValue: addFarmerBuild,
//                             onChanged: (value) {
//                               ref.read(addFarmer11Provider.notifier).state =
//                                   value!;
//                             },
//                           ),
//                           Text(addCategaryTxt[index]['txt'].toString()),
//                         ],
//                       ))),
//           const Divider(),
//         ],
//       ),
//     );
//   }
// }


