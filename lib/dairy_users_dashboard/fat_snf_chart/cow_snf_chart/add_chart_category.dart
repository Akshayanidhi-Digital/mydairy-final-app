import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

class AddChartCateroryScreen extends ConsumerStatefulWidget {
  const AddChartCateroryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddChartCateroryScreenState();
}

class _AddChartCateroryScreenState
    extends ConsumerState<AddChartCateroryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Add Chart Category",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            RSizedBox(height: 40.h),
            const TxtField(
              labelText: "Name",
              hintText: "Name",
            ),
            RSizedBox(height: 40.h),
            buttonContainer(txt: "Submit", width: double.infinity)
          ],
        ),
      ),
    );
  }
}
