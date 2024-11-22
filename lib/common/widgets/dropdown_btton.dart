import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

dropdownBtn(
    {List? listitem,
    String? value,
    String? bydefalutselect,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
    FocusNode? focusNode,
    required void Function(String? value)? onChanged}) {
  return Container(
    margin: margin,
    decoration: BoxDecoration(border: Border.all()),
    child: Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          focusNode: focusNode,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          isExpanded: true,
          value: value,
          items: [
            DropdownMenuItem(
              value: "",
              child: Text(
                bydefalutselect!,
                style: const TextStyle(
                    color: AppColor.blackClr, fontWeight: FontWeight.normal),
              ),
            ),
            ...listitem!.map<DropdownMenuItem<String>>((datas) {
              return DropdownMenuItem(
                  value: datas['value'],
                  child: Text(datas['title'],
                      style: TextStyle(color: AppColor.blackClr)));
            }),
          ],
          onChanged: onChanged,
        ),
      ),
    ),
  );
}

class CtmDropDown extends ConsumerWidget {
  final List<DropdownMenuItem<String>>? lst;
  final String? hintTxt;
  final BorderRadiusGeometry? borderRadius;
  final String? inisialvalue;
  final void Function(String? value)? onChanged;
  const CtmDropDown(
      {super.key,
      this.lst,
      this.hintTxt,
      this.inisialvalue,
      this.onChanged,
      this.borderRadius});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          '$hintTxt',
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 14.sp,
              color: AppColor.blackClr,
              fontWeight: FontWeight.w400),
        ),
        items: lst!,
        value: inisialvalue,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.blackClr),
                borderRadius: borderRadius ?? BorderRadius.circular(2)),
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            height: 42.sp,
            width: double.infinity),
        dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10))),
        menuItemStyleData: MenuItemStyleData(height: 40.sp),
      ),
    );
  }
}
