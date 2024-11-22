import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydairy/export.dart';
import 'package:permission_handler/permission_handler.dart';
// //  Selected Date

final imageUploaderProvider = StateProvider.autoDispose((ref) {
  return ImageUploadNotifier(ref: ref).imageUplaod();
});

final imageProvider = StateProvider.autoDispose<File?>((ref) {
  return null;
});
final imageNameProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

class ImageUploadNotifier {
  Ref ref;

  ImageUploadNotifier({required this.ref});

  Future imageUplaod() async {
    try {
      await Permission.mediaLibrary.request();
      var status = await Permission.mediaLibrary.status;
      if (status.isGranted) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            onFileLoading: (value) {
              print("loading ::  $value");
            },
            compressionQuality: 5,
            allowCompression: true,
            allowedExtensions: ['png', 'jpg', 'jpeg']);

        if (result != null) {
          File file = File(result.files.single.path!);
          ref.read(imageProvider.notifier).state = file;
          ref.read(imageNameProvider.notifier).state =
              file.path.split('/').last;
          String filename = file.path.split('/').last;

          snackBarMessage(msg: "file Pic $filename", color: AppColor.greenClr);
        } else {
          snackBarMessage(msg: "No file Selected");
          print("No file selected");
        }
      } else {
        // await Permission.storage.request();
        openAppSettings();

        await Permission.storage.request();

        // await Permission.photos.isRestricted;
      }
    } catch (e) {
      print("::::${e.toString()}");
    }
  }
}

String formattedDate = '';
Future selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
  );
  print("PIC    $pickedDate");

  if (pickedDate != null) {
    formattedDate =
        "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    print("format   $formattedDate");
    return formattedDate;
  }
}

// //  Selected Time
Future selectTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
          data: ThemeData(primaryColor: AppColor.greenClr), child: child!);
    },
  );

  if (pickedTime != null && context.mounted) {
    return pickedTime.format(context);
  }
}

// // Selected DateRange

class TxtField extends StatelessWidget {
  // // TextFormField
  final String? headTxt, labelText, hintText, errorText, initialValue;
  final TextEditingController? controller;
  final int? maxLines, minLines, maxLength;
  final void Function()? onTap;
  final dynamic onTapOutside;
  final double? cursorHeight;
  final Function? validator;
  final BoxDecoration? decoration;
  final Function(String?)? onSaved, onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon, prefixIcon;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;
  final TextStyle? style, htstyle, lableStyle;
  final bool? readOnly, filled, border, hintStyle, bordertype;
  final Color? fillColor, enableBorderColor, errorColor;

  final bool? enabled;
  final bool? obscureText;
  final FocusNode? focusNode;
  final BorderRadius? borderRadius;
  const TxtField(
      {super.key,
      this.focusNode,
      this.errorColor,
      this.borderRadius,
      this.hintStyle,
      this.htstyle,
      this.lableStyle,
      this.bordertype = true,
      this.enableBorderColor,
      this.headTxt,
      this.enabled,
      this.cursorHeight,
      this.contentPadding,
      this.textAlign,
      this.decoration,
      this.obscureText,
      this.controller,
      this.labelText,
      this.errorText,
      this.inputFormatters,
      this.keyboardType,
      this.initialValue,
      this.maxLength,
      this.minLines,
      this.maxLines,
      this.onSaved,
      this.onChanged,
      this.readOnly,
      this.onTap,
      this.suffixIcon,
      this.prefixIcon,
      this.hintText,
      this.border = true,
      this.filled,
      this.fillColor,
      this.validator,
      this.style,
      this.onTapOutside});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          // FocusScope.of(context).requestFocus(_focus);
        },
        child: TextFormField(
            focusNode: focusNode,
            enabled: enabled ?? true,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            onTap: onTap,
            initialValue: initialValue,
            style: style ??
                const TextStyle(fontSize: 16.0, color: AppColor.blackClr),
            textAlign: textAlign ?? TextAlign.start,
            onChanged: onChanged,
            obscureText: obscureText ?? false,
            // cursorHeight: cursorHeight ?? 25.0,
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: maxLines ?? 1,
            minLines: minLines,
            maxLength: maxLength,
            controller: controller,
            onSaved: onSaved,
            keyboardType: keyboardType,
            validator: validator != null ? (value) => validator!(value) : null,
            readOnly: readOnly ?? false,
            scrollPadding: EdgeInsets.zero,
            decoration: InputDecoration(
                isDense: true,
                fillColor: fillColor ?? const Color(0XFFfafafa),
                filled: filled ?? true,
                errorStyle: TextStyle(
                    color: errorColor ?? AppColor.redClr, fontSize: 14),
                errorMaxLines: 3,
                errorText: errorText,
                counter: const Offstage(),
                hintStyle: htstyle ??
                    const TextStyle(
                        fontSize: 16.0,
                        color: AppColor.blackClr,
                        fontWeight: FontWeight.normal),
                labelStyle: lableStyle ??
                    const TextStyle(
                        fontSize: 16.0,
                        color: AppColor.blackClr,
                        fontWeight: FontWeight.normal),
                labelText: labelText,
                enabledBorder: bordertype == false
                    ? null
                    : OutlineInputBorder(
                        borderRadius: borderRadius ?? BorderRadius.circular(0),
                        borderSide: BorderSide(
                          color: enableBorderColor ?? AppColor.blackClr,
                        )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(0),
                    borderSide:
                        const BorderSide(color: AppColor.appColor, width: 1)),
                border: border == true
                    ? OutlineInputBorder(
                        borderRadius: borderRadius ?? BorderRadius.circular(0),
                        borderSide: const BorderSide(
                            color: AppColor.appColor, width: 0.5))
                    : null,
                hintText: hintText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                contentPadding: EdgeInsets.all(10.w))));
  }
}

// ! Validation For  TextFormField

// validateField(String value) {
//   if (value.isEmpty) {
//     return 'Field is Required.';
//   } else {
//     return null;
//   }
// }

String? validateNameField(String value, String name) {
  if (value.isEmpty) {
    return 'Please enter $name';
  } else {
    return null;
  }
}

String valueMobile(String value) {
  if (value.length > 10) {
    return value = value.substring(0, 10);
  } else {
    return value;
  }
}

// bool mobile_digit = false;
String? validateMobile(String value) {
  if (value.isEmpty) {
    return Msg.number_required;
  } else if (value.length >= 10 && !Msg.phoneregExp.hasMatch(value)) {
    return Msg.number_invalide;
  } else {
    return null;
  }
}

String? validateOTP(String value) {
  if (value.isEmpty) {
    return Msg.otp_required;
  } else if (value.length < 4) {
    return Msg.otp_invalide;
  } else {
    return null;
  }
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return Msg.password_required;
  } else if (value.length < 6) {
    return Msg.password_invalide;
    // } else if (value.length > 6) {
    //   return 'Password required at most 6 numbers';
  } else {
    return null;
  }
}
