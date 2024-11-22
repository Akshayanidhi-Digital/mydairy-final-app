import 'dart:developer';
import 'package:flutter/material.dart';
import '../../export.dart';

class LoadingdataScreen extends ConsumerWidget {
  final Widget Function(dynamic data) data;
  final AsyncValue<dynamic>? varBuild;
  const LoadingdataScreen({super.key, required this.data, this.varBuild});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errors = ref.watch(errorProvider);
    final internet = ref.watch(internetProvider);
    return varBuild!.when(
        skipLoadingOnReload: true,
        // skipLoadingOnRefresh: true,
        error: (error, stackTrace) {
          log("::::Errors Provider :::  ::  :::  $error...$stackTrace");
          return errorMsg();
        },
        loading: () => Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  LoadingIndicator(),
                  // const CircularProgressIndicator(color: AppColor.appColor),
                  RSizedBox(height: 10.sp),
                  const Text("Loading...",
                      style: TextStyle(color: AppColor.appColor))
                ])),
        data: (snap) {
          if (snap != null) {
            return data(snap);
          } else if (snap.isEmpty || snap == []) {
            print("empty list");
            return emptyList();
          } else {
            if (internet == true) {
              return const Center(child: Text(Msg.noInternet));
            } else {
              return Center(
                  child: Text((errors.isNotEmpty) ? errors : Msg.somethingWrong,
                      style:
                          TextStyle(color: AppColor.redClr, fontSize: 14.sp)));
            }
          }
        });
  }
}

final internetProvider = StateProvider.autoDispose<bool?>((ref) => null);

Widget errorMsg() {
  return Center(
      child: Text(
    textAlign: TextAlign.center,
    Msg.sometechnicalissue,
    style: TextStyle(color: AppColor.appColor, fontSize: 14.sp),
  ));
}

class LoadingIndicator extends StatefulWidget {
  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: SweepGradient(colors: [
              AppColor.appColor,
              AppColor.redClr,
              AppColor.greenClr,
              Colors.indigo,
              Colors.black,
              Colors.pink,
              Colors.purple,
              AppColor.appColor,
            ])),
        width: 50.w,
        height: 50.h,
        child: Padding(
          padding: EdgeInsets.all(5.0.r),
          child: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              color: AppColor.whiteClr,
            ),
            height: 10.h,
            width: 10.w,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
