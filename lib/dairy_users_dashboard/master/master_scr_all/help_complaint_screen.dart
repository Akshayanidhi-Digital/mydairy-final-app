import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

class HelpAndComplaint extends ConsumerStatefulWidget {
  const HelpAndComplaint({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HelpAndComplaintState();
}

class _HelpAndComplaintState extends ConsumerState<HelpAndComplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Help/Complaint",
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                RSizedBox(height: 50.h),
                TxtField(
                  borderRadius: BorderRadius.circular(5),
                  hintText: "Subject",
                ),
                RSizedBox(height: 20.h),
                TxtField(
                  borderRadius: BorderRadius.circular(5),
                  maxLines: 10,
                  hintText: "Enter Containt",
                ),
                RSizedBox(height: 30.h),
                buttonContainer(width: double.infinity, txt: "Submit")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
