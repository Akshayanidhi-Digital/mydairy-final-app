import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

import '../../authentication/sign_up.dart';

class CustomDialogExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Dialog')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    height: 200,
                    width: 300,
                    color: Colors.orangeAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Custom Animated Dialog',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Text('Show Dialog'),
        ),
      ),
    );
  }
}

class AlertDialogBox extends StatelessWidget {
  // Alert Dialog Box
  final dynamic icon, actions;
  final MainAxisAlignment? actionsAlignment;
  final TextAlign? textAlign;
  final String? title, content, setting;
  final Function()? onPressed1, onPressed2;
  final TextStyle? titleTextStyle;
  const AlertDialogBox(
      {super.key,
      this.setting,
      this.titleTextStyle,
      this.textAlign,
      this.actionsAlignment,
      this.actions,
      this.icon,
      this.content = '',
      this.title = '',
      this.onPressed1,
      this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.whiteClr,
      contentPadding: const EdgeInsets.all(0),
      titleTextStyle: titleTextStyle,
      title: icon ?? Text(title!, textAlign: textAlign),
      content: Text(
        content!,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: actionsAlignment,
      actions: actions ??
          <Widget>[
            TextButton(
              onPressed: onPressed1,
              child: const Text(
                "Cancel",
                style: TextStyle(color: AppColor.appColor, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: onPressed2,
              child: Text(setting ?? "Ok",
                  style: TextStyle(color: AppColor.appColor, fontSize: 16)),
            ),
          ],
    );
  }
}

void showPopup(mobile, Map? mydata) {
  List name = mydata!.keys.toList();
  List value = mydata.values.toList();

  showDialog(
    context: Keys.navigatorKey().currentState!.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(child: Text("Login")),
        alignment: Alignment.center,
        titleTextStyle: const TextStyle(
            color: AppColor.appColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w700),
        content: SingleChildScrollView(
          child: ListBody(
            children: List.generate(
              name.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 1.sp),
                child: ElevatedButton(
                  onPressed: () {
                    navigationTo(
                      LogInScreen(
                        mobile: mobile,
                        accounttype: value[index],
                        name: name[index],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppColor.appColor,
                    foregroundColor: AppColor.whiteClr,
                  ),
                  child: Text(name[index].toString()),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

void showRegisterPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(child: Text("Register")),
        alignment: Alignment.center,
        titleTextStyle: const TextStyle(
            color: AppColor.appColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w700),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  navigationTo(const SignUpScreen());
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColor.appColor,
                  foregroundColor: AppColor.whiteClr,
                ),
                child: const Text('Dairy'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
