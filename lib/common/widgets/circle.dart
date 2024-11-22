import 'dart:io';
import 'package:flutter/material.dart';

class CircleProfile extends StatelessWidget {
  final String filePath;
  final Color? bckcolor1;
  final bool fileUpload;
  final double? radius1, radius2;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  const CircleProfile({
    super.key,
    this.backgroundColor,
    this.radius1,
    this.radius2,
    this.fileUpload = false,
    this.filePath = '',
    this.bckcolor1,
    this.iconSize,
    this.iconColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: radius1,
        backgroundColor: backgroundColor,
        child: CircleAvatar(
          radius: radius2,
          child: ClipOval(
              child: filePath.isNotEmpty && fileUpload == true
                  ? Image.file(File(filePath),
                      width: 140, height: 140, fit: BoxFit.cover)
                  : filePath.isNotEmpty && fileUpload == false
                      ? Image.network(filePath,
                          width: 140, height: 140, fit: BoxFit.cover)
                      : Icon(icon ?? Icons.person,
                          size: iconSize ?? 50, color: iconColor)),
        ),
      ),
    );
  }
}
