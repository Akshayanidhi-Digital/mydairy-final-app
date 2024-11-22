import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import '../../common/widgets/switch_button.dart';
import '../customers/add_customer/controller.dart';
import 'sift_time_m_e/controller.dart';
import '../model/Costumer_list_model.dart';

class SwitchScr extends StatefulWidget {
  final String text;
  const SwitchScr({super.key, this.text = ''});

  @override
  State<SwitchScr> createState() => _SwitchScrState();
}

class _SwitchScrState extends State<SwitchScr> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          leading: switchButton(
              positive: switchValue,
              onTap: (_) => setState(() => switchValue = !switchValue)),
          title: Text(
            widget.text,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.w),
          ),
        ),
        const Divider()
      ],
    );
  }
}

class DragableListSrc extends ConsumerStatefulWidget {
  final bool type;
  const DragableListSrc({super.key, required this.type});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DragableListSrcState();
}

class _DragableListSrcState extends ConsumerState<DragableListSrc> {
  @override
  Widget build(BuildContext context) {
    final customerListBuild = ref.watch(customerListProvider);
    return DraggableScrollableSheet(
      snapAnimationDuration: Durations.extralong3,
      expand: false,
      builder: (__, controller) => LoadingdataScreen(
        varBuild: customerListBuild,
        //  widget.type == false ? farmerList : buyerList,
        data: (mydata) {
          List<CostumerModel> data = [];
          for (var i = 0; i < mydata.length; i++) {
            data.add(CostumerModel.fromJson(mydata[i]));
          }
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: AppColor.greenClr,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  height: 20,
                  width: double.infinity,
                  child: Center(
                      child: Container(
                          height: 3, width: 50, color: AppColor.whiteClr))),
              ListView(
                shrinkWrap: true,
                controller: controller,
                children: List.generate(
                  data.length,
                  (index) => Container(
                    child: data.length > 0
                        ? ListTile(
                            leading: Text(
                              "${index + 1}",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            title: Row(
                              children: [
                                Text(data[index].name.toString()),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.sp),
                                  child: Text(data[index].mobile.toString()),
                                ),
                              ],
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: AppColor.appColor,
                              radius: 15.r,
                              child: Icon(Icons.add, color: AppColor.whiteClr),
                            ),
                            onTap: () async {
                              ref.refresh(backDataProvider.notifier).state;
                              ref.read(backDataProvider.notifier).state.clear();
                              ref
                                  .read(backDataProvider.notifier)
                                  .state
                                  .add(await data[index]);
                              navigationPop();
                              ref
                                  .read(siftControllerProvider.notifier)
                                  .fatController
                                  .text = "";
                              ref
                                  .read(siftControllerProvider.notifier)
                                  .weightController
                                  .text = "";
                              ref
                                  .read(siftControllerProvider.notifier)
                                  .snfController
                                  .text = "";
                              ref.read(getListProvider.notifier).state.clear();
                              ref.read(milkTypeValueprovider.notifier).state =
                                  "";
                            },
                          )
                        : const Center(
                            child: Text("No data"),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
