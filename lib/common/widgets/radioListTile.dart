// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'colors.dart';



class RadioListValue extends StatelessWidget {
  final Widget? title;
  final int? value;
  final int? groupValue;
  void Function(dynamic)? onChanged;
  RadioListValue(
      {super.key,
      this.title,
      this.value,
      this.groupValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      activeColor: AppColor.appColor,
      visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: title,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
