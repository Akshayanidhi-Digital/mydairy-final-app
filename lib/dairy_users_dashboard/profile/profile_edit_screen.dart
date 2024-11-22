import 'package:flutter/material.dart';
import 'package:mydairy/dairy_users_dashboard/model/profile_model.dart';
import 'package:mydairy/export.dart';

import 'controller.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  final ProfileModel? data;
  const ProfileEditScreen({super.key, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  @override
  void initState() {
    ref.read(profileProvider.notifier).profileData(data: widget.data) ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textController = ref.watch(profileProvider.notifier);
    final image = ref.watch(imageProvider);

    return Scaffold(
        appBar: BaseAppBar(title: "Profile Edit", centerTitle: true),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.appColor,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.elliptical(200, 90))),
                height: 201.h,
                child: Stack(
                  children: [
                    Center(
                        child: (image != null)
                            ? GestureDetector(
                                onTap: () {
                                  ref.read(imageUploaderProvider.notifier);
                                },
                                child: CircleAvatar(
                                  radius: 55.sp,
                                  backgroundImage: FileImage(image),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  ref.read(imageUploaderProvider.notifier);
                                },
                                child: CircleAvatar(
                                  radius: 55.sp,
                                  backgroundImage: NetworkImage(Url.image +
                                      widget.data!.profile!.imagePath
                                          .toString()),
                                ),
                              )),
                    Center(
                      child: Icon(
                        Icons.photo_camera_rounded,
                        size: 28.sp,
                        color: AppColor.whiteClr,
                      ),
                    ),
                  ],
                )),
            RSizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(children: [
                TxtField(
                    enableBorderColor: AppColor.bluedarkClr,
                    labelText: 'Name',
                    controller: textController.nameController,
                    prefixIcon: Icon(size: 25.sp, Icons.person),
                    hintText: 'Name'),
                RSizedBox(height: 10.sp),
                TxtField(
                    enableBorderColor: AppColor.bluedarkClr,
                    labelText: "Father Name",
                    controller: textController.fathernameController,
                    prefixIcon: Icon(size: 25.sp, Icons.person),
                    hintText: 'Father Name'),
                RSizedBox(height: 10.sp),
                TxtField(
                    enableBorderColor: AppColor.bluedarkClr,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    controller: textController.mobileController,
                    prefixIcon: Icon(size: 25.sp, Icons.phone_android),
                    hintText: 'Mobile',
                    labelText: 'Mobile'),
                RSizedBox(height: 10.sp),
                TxtField(
                    enableBorderColor: AppColor.bluedarkClr,
                    controller: textController.dairyNameController,
                    prefixIcon: Icon(size: 25.sp, Icons.home),
                    hintText: 'Dairy Name',
                    labelText: 'Dairy Name'),
                RSizedBox(height: 10.sp),
                TxtField(
                    enableBorderColor: AppColor.bluedarkClr,
                    controller: textController.emailController,
                    prefixIcon: Icon(Icons.email, size: 25.sp),
                    hintText: 'Email',
                    labelText: 'Email'),
                RSizedBox(height: 10.sp),
                TxtField(
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 40,
                    enableBorderColor: AppColor.bluedarkClr,
                    controller: textController.addressController,
                    prefixIcon: Icon(Icons.location_city, size: 25.sp),
                    hintText: 'Address',
                    labelText: 'Address'),
                RSizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: buttonContainer(
                      loder: ref.watch(loadingProvider),
                      onTap: () async {
                        Future.delayed(
                          const Duration(milliseconds: 1),
                          () {
                            Future(() async => await ref
                                .read(profileProvider.notifier)
                                .profileUpdateApi(image: image));
                          },
                        );
                      },
                      hight: 46.0.h,
                      txt: "Update",
                      width: double.infinity),
                ),
                RSizedBox(height: 30.h),
              ]),
            )
          ],
        ));
  }
}
