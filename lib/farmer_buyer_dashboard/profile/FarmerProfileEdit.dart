import 'package:flutter/material.dart';

import '../../dairy_users_dashboard/model/farmer_buyer_profile_model.dart';
import '../../export.dart';

class Farmerprofileedit extends ConsumerStatefulWidget {
  final FarmerBuyerData? farmer;

  const Farmerprofileedit({super.key, required this.farmer});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerprofileeditState();
}

class _FarmerprofileeditState extends ConsumerState<Farmerprofileedit> {
  final nameCtrl = TextEditingController();
  final fatherNameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final centerNameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  @override
  void initState() {
    nameCtrl.text = widget.farmer!.name!;
    fatherNameCtrl.text = widget.farmer!.fatherName!;
    mobileCtrl.text = widget.farmer!.mobile!;
    centerNameCtrl.text = widget.farmer!.dairy!;
    // addressCtrl.text = widget.farmer!.dairy!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.appColor,
            automaticallyImplyLeading: false,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:
                          Icon(Icons.arrow_back_ios, color: AppColor.whiteClr)),
                  Text("Profile Edit",
                      style: TextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColor.whiteClr))
                ])),
        body: Container(
            padding: EdgeInsets.all(20.r),
            height: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // TextFormField(
              //     style:
              //         TextStyle(color: AppColor.appColor, fontSize: 16.0),
              //     initialValue: farmer!.name,
              //     decoration: InputDecoration(
              //         labelText: 'Name',
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10)))),
              Text("Name", style: TextStyle(color: AppColor.blackClr)),
              TextFormField(
                  style: TextStyle(color: AppColor.appColor, fontSize: 16.0.sp),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  controller: nameCtrl,
                  decoration: InputDecoration(hintText: "Name")),
              RSizedBox(height: 20.sp),
              Text("Father Name", style: TextStyle(color: AppColor.blackClr)),
              TextFormField(
                  style: TextStyle(color: AppColor.appColor, fontSize: 16.0.sp),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  controller: fatherNameCtrl,
                  decoration: InputDecoration(hintText: "Father Name")),
              RSizedBox(height: 20.sp),
              Text("Mobile Number", style: TextStyle(color: AppColor.blackClr)),
              TextFormField(
                  style: TextStyle(color: AppColor.appColor, fontSize: 16.0.sp),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  controller: mobileCtrl,
                  decoration: InputDecoration(hintText: "Mobile Number")),
              RSizedBox(height: 20.sp),
              Text("Center Name", style: TextStyle(color: AppColor.blackClr)),
              TextFormField(
                  style: TextStyle(color: AppColor.appColor, fontSize: 16.0.sp),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  controller: centerNameCtrl,
                  decoration: InputDecoration(hintText: "Center Name")),
              RSizedBox(height: 20.sp),
              TextFormField(
                  style: TextStyle(color: AppColor.appColor, fontSize: 16.0.sp),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  controller: addressCtrl,
                  decoration: InputDecoration(
                      hintText: "Address",
                      suffixIcon: Icon(Icons.location_on_outlined))),
              RSizedBox(height: 18.sp),
              Text(
                "Dairy Owner Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
              RSizedBox(height: 10.sp),
              Text(
                  "Note: if you know any dairy owner who sale milk to you or where form you or where form you buy milk. you can fill details of him."),
              RSizedBox(height: 10.sp),
              buttonContainer(txt: "Update", width: double.infinity)
            ])));
  }
}
