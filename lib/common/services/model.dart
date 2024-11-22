import 'package:flutter/material.dart';

class MasterItem {
  String image;
  String txt;
  Widget? page;
  MasterItem({required this.image, required this.txt, this.page});
}

class TxtModel {
  String txt;
  TxtModel({required this.txt});
}

class HomeImage {
  String image;
  String name;
  Function ontap;
  HomeImage({required this.image, required this.name, required this.ontap});
}
