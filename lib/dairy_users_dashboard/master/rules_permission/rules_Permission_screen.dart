import 'package:flutter/material.dart';
import 'package:mydairy/common/services/model.dart';
import '../../../export.dart';
import '../../model/rules_model.dart';
import '../controllers/role_controller.dart';
import 'permission_src.dart';

class RulesAndPermissionScreen extends ConsumerWidget {
  const RulesAndPermissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rulesApi = ref.watch(rulesGetProvider);
    return Scaffold(
      appBar: BaseAppBar(title: "Rules & Permission"),
      body: LoadingdataScreen(
        varBuild: rulesApi,
        data: (data) {
          Map<String, dynamic> mydatat = {'data': data};
          RulesModel rules = RulesModel.fromJson(mydatat);
          return Padding(
            padding: EdgeInsets.only(top: 20.0.h),
            child: Column(
              children: [
                Container(
                  height: 50.h,
                  color: AppColor.appColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          rulesTxtlist.length,
                          (index) => Text(rulesTxtlist[index].txt,
                              style: TextStyle(
                                  color: AppColor.whiteClr, fontSize: 14.w)),
                        )),
                  ),
                ),
                SizedBox(height: 10.h),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: rules.data!.length,
                    itemBuilder: (context, index) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  rules.data![index].shortName.toString(),
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                                RSizedBox(width: 10.w),
                                RSizedBox(
                                  width: 152.w,
                                  child:
                                      Text(rules.data![index].name.toString(),
                                          style: TextStyle(
                                            fontSize: 16.0.w,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                ),
                                RSizedBox(width: 10.w),
                                buttonContainer(
                                    onTap: () {
                                      navigationTo(PermissionSrc(
                                          id: rules.data![index].roleId
                                              .toString()));
                                    },
                                    fontSize: 12.sp,
                                    hight: 23.h,
                                    width: 49.w,
                                    txt: "View")
                              ],
                            ),
                            const Divider()
                          ],
                        ))
              ],
            ),
          );
        },
      ),
    );
  }
}

List<TxtModel> rulesTxtlist = [
  TxtModel(txt: "Short Name"),
  TxtModel(txt: "Name"),
  TxtModel(txt: "Action"),
];
