// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:mydairy/export.dart';

// List textFields = [];

// class AddCowChartScreen extends ConsumerStatefulWidget {
//   const AddCowChartScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _AddCowChartScreenState();
// }

// class _AddCowChartScreenState extends ConsumerState<AddCowChartScreen> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   final List<TextEditingController> controllers = [];
//   // TextEditingController nameContoller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     textFieldUpdate();
//   }

//   textFieldUpdate() {
//     ref.read(textFormListProvider).whenData((value) {
//       textFields = value;
//     });
//     // Initialize controllers
//     for (int i = 0; i < textFields.length; i++) {
//       controllers.add(TextEditingController());
//     }
//   }

//   @override
//   void dispose() {
//     // TxtEditorController.controller.clear();
//     controllers.clear();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BaseAppBar(title: "Add Cow Chart"),
//       body: Form(
//         key: formKey,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 RSizedBox(
//                   width: 190,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       RSizedBox(height: 20.h),
//                       Padding(
//                         padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
//                         child: const Text(
//                           "Fat",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: textFields.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 8.0, horizontal: 16.0),
//                             child: TxtField(
//                               controller: controllers[index],

//                               labelText: textFields[index]['labelText'],
//                               hintText: textFields[index]['hintText'],
//                               // border: true,

//                               validator: (value) =>
//                                   validateFields(value: value, index: index),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: 1.w,
//                   height: 250.h,
//                   color: Colors.grey,
//                 ),
//                 RSizedBox(
//                   width: 190,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       RSizedBox(height: 20.h),
//                       Padding(
//                         padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
//                         child: const Text(
//                           "SNF",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: textFields.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 8.0, horizontal: 16.0),
//                             child: TxtField(
//                               controller: textFields[index]['controller'],

//                               labelText: textFields[index]['labelText'],
//                               hintText: textFields[index]['hintText'],
//                               // border: true,

//                               // validator: (value) =>
//                               //     validateFields(value: value, index: index),
//                               onChanged: (value) {
//                                 print(".......value $value");
//                                 print(
//                                     ".......txt0 -> ${TxtEditorController.controller[0].text}");
//                                 print(
//                                     ".......txt1 -> ${TxtEditorController.controller[1].text}");
//                                 print(
//                                     ".......txt2 -> ${TxtEditorController.controller[2].text}");
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             RSizedBox(height: 20.h),
//             buttonContainer(
//                 onTap: () {
//                   bool? isvalid = formKey.currentState!.validate();

//                   if (isvalid == true) {
//                     formKey.currentState!.save();
//                     for (int i = 0; i < controllers.length; i++) {
//                       log("contollers list $i ${controllers[i].text}");
//                     }
//                   }
//                 },
//                 txt: "Save Rate")
//           ],
//         ),
//       ),
//     );
//   }
// }

// final controllerListProvider = StateProvider.autoDispose<List>((ref) {
//   return List.filled(15, (index) => TextEditingController());
// });

// //  TextFormField data dynamically
// class TxtEditorController {
//   // static final controller = TextEditingController();
//   static final List<TextEditingController> controller =
//       List.generate(3, (index) => TextEditingController());
// }

// final textFormListProvider = FutureProvider<List>((ref) {
//   List textFormFields = [
//     {
//       "labelText": "From",
//       "hintText": "From",
//       "minLines": 20,
//       "validator": validateFields,
//       "controller": TxtEditorController.controller[0]
//     },
//     {
//       "labelText": "To",
//       "hintText": "To",
//       "validator": validateFields,
//       "controller": TxtEditorController.controller[1]
//     },
//     {
//       "labelText": "Rate",
//       "hintText": "Rate",
//       "minLines": 20,
//       "validator": validateFields,
//       "controller": TxtEditorController.controller[2]
//     },
//   ];
//   return textFormFields;
// });
// validateFields({String? value, index}) {
//   if (value == null || value.isEmpty) {
//     return 'Please enter a ${textFields[index]['labelText']}';
//   }

//   return null;
// }
