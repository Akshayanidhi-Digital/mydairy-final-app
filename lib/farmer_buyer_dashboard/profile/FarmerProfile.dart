// ignore_for_file: must_be_immutable, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

import 'package:qr_flutter/qr_flutter.dart';

import '../../dairy_users_dashboard/model/farmer_buyer_profile_model.dart';
import 'FarmerProfileEdit.dart';

class Farmerprofile extends ConsumerWidget {
  late List<FarmerBuyerData>? farmer;

  Farmerprofile({super.key, required this.farmer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appColor,
        automaticallyImplyLeading: false,
        title: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image(
              image: AssetImage(Img.logo),
              width: 30,
              height: 30,
            ),
            RSizedBox(
              width: 10,
            ),
            Text(
              "Profile",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  color: AppColor.whiteClr),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: AppColor.whiteClr,
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: AppColor.appColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RSizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the border radius as needed
                      child: QrImageView(
                        semanticsLabel: 'Farmer profile at Mydairy',
                        data:
                            'Fmob. : ${farmer![0].countryCode} ${farmer![0].mobile}',
                        version: QrVersions.auto,
                        size: 200.0,
                        backgroundColor: AppColor.appColor,
                        padding: EdgeInsets.all(10),
                        foregroundColor: AppColor.whiteClr,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColor.redClr),
                          iconColor:
                              WidgetStateProperty.all(AppColor.whiteClr)),
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        navigationTo(
                          Farmerprofileedit(
                            farmer: farmer![0],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              RSizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _logoutFormAllPopup();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColor.redClr),
                  ),
                  child: Text(
                    'Logout form other Device',
                    style: TextStyle(color: AppColor.whiteClr),
                  ),
                ),
              ),
              RSizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder(
                  horizontalInside: BorderSide(color: AppColor.whiteClr),
                  bottom: BorderSide(color: AppColor.whiteClr),
                ),
                children: [
                  profileTxt("Name", farmer![0].name.toString()),
                  profileTxt("Father name", farmer![0].fatherName.toString()),
                  profileTxt("Mobile No",
                      "${farmer![0].countryCode} ${farmer![0].mobile}"),
                  profileTxt("Center Name", farmer![0].dairy.toString()),
                  profileTxt("Address", ""),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  profileTxt(String txt1, String txt2) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              txt1,
              style: TextStyle(color: AppColor.whiteClr, fontSize: 16.0),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              ":",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.whiteClr, fontSize: 16.0),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              txt2,
              style: TextStyle(
                color: AppColor.whiteClr,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _logoutFormAllPopup() {
    showDialog(
      context: Keys.navigatorKey().currentState!.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout from all devices"),
          content: Text("Are you sure you want to logout from all devices?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _logoutFromAllDevices();
                Navigator.of(context).pop();
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  void _logoutFromAllDevices() {
    snackBarMessage(
        msg: "Logged out from all devices successfully",
        color: AppColor.redClr);
  }
}
