import 'package:flutter/material.dart';
import 'package:mydairy/dairy_users_dashboard/master/controllers/role_controller.dart';

import '../../../common/widgets/switch_button.dart';
import '../../../export.dart';
import '../controllers/role_apis.dart';

// final permissionListProvider = StateProvider.autoDispose((ref) => []);
final permissionValueProvider = StateProvider.autoDispose<bool?>((ref) => null);
Map<String, dynamic> permissionList = {};

class PermissionSrc extends ConsumerStatefulWidget {
  final String id;
  const PermissionSrc({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PermissionSrcState();
}

class _PermissionSrcState extends ConsumerState<PermissionSrc> {
  @override
  Widget build(BuildContext context) {
    final rulesViewApi = ref.watch(rulesViewGetProvider.call(widget.id));

    return Scaffold(
      appBar: BaseAppBar(title: "Rules & Permission"),
      body: LoadingdataScreen(
        varBuild: rulesViewApi,
        data: (data) {
          // Map mydata = data;
          var nameList = permission.keys.toList();
          return Padding(
            padding: EdgeInsets.all(10.0.sp),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: nameList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                            child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Text(
                              nameList[index].toString(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: AppColor.appColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            ...permission[nameList[index]].map((e) {
                              bool permissionvalues =
                                  e['access'] == 0 ? false : true;
                              return ListTile(
                                title: Text(
                                  e['permission_name']
                                      .toString()
                                      .split('.')
                                      .join(' ')
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                trailing: switchButton(
                                  positive: permissionvalues,
                                  onTap: (_) {
                                    setState(() {
                                      if (e['access'] == 0) {
                                        e['access'] = 1;
                                        permissionvalues = false;
                                      } else {
                                        e['access'] = 0;
                                        permissionvalues = true;
                                      }

                                      permissionvalues = !permissionvalues;

                                      permissionList.addAll({
                                        e['permission_id'].toString():
                                            permissionvalues
                                      });
                                    });
                                  },
                                ),
                              );
                            })
                          ],
                        ))),
                  ),
                ),
                RSizedBox(height: 20.sp),
                buttonContainer(
                    loder: ref.watch(loadingProvider),
                    onTap: () {
                      var roles = {
                        "role_id": widget.id,
                        "permissions": permissionList
                      };

                      ref.read(rulesApiProvider).rulesUpdate(roles);

                      print("data list ...${roles}");
                    },
                    txt: "Submit",
                    width: double.infinity),
                RSizedBox(height: 20.sp),
              ],
            ),
          );
        },
      ),
    );
  }
}
