import 'package:flutter/material.dart';
import '../../../export.dart';
import '../../model/routes_list_model.dart';
import '../apis.dart';
import '../controller.dart';
import 'route_ctr.dart';

final trValueProvider = StateProvider.autoDispose<String>((ref) => '');

class AddRoutesScreen extends ConsumerStatefulWidget {
  final bool edit;
  final RouteListModel? data;
  const AddRoutesScreen({super.key, this.edit = false, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddRoutesScreenState();
}

class _AddRoutesScreenState extends ConsumerState<AddRoutesScreen> {
  @override
  void initState() {
    ref.read(routeValueProvider.notifier).state.add(
        RoutesAddModel(userId: null, name: '', roleName: '', select: true));

    if (widget.edit == true) {
      // ref.read(subDairyProvider.notifier).sub_dairy_length();
      ref.read(masterApiProvider).dairy_listApi().then(
        (value) {
          ref
              .read(subDairyProvider.notifier)
              .initData(widget.data!, name: namecontroller);
        },
      );

      setState(() {});
    } else {
      ref.read(masterApiProvider).dairy_listApi();
      ref.read(subDairyProvider);
      ref.read(transportListApiProvider);
      ref.read(transportListProvider);
    }

    super.initState();
  }

  final namecontroller = TextEditingController();
  String type = "";

  @override
  Widget build(BuildContext context) {
    ref.watch(transportListApiProvider);
    final transporter = ref.watch(transportListProvider);
    final typeValue = ref.watch(trValueProvider);
    final routeValue = ref.watch(routeValueProvider);
    final sub_dairy = ref.watch(subDairyProvider);
    print("sub dairy length ${sub_dairy.length}");
    print("routevalue length :: ${routeValue.length}");
    routeValue.map(
      (e) {
        print("routevalue::::::::::::::::: ${e!.userId}");
      },
    );
    setState(() {});
    // ref.watch(subDairyProvider);

    return Scaffold(
      appBar: BaseAppBar(title: widget.edit ? "Edit Route" : "Add Routes"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RSizedBox(height: 15.h),
              Text("Transporter", style: TextStyle(fontSize: 16.sp)),
              CtmDropDown(
                  inisialvalue: typeValue == '' ? null : typeValue,
                  onChanged: (value) {
                    ref.read(trValueProvider.notifier).state = value!;
                  },
                  hintTxt: "Select type",
                  lst: transporter.isEmpty
                      ? []
                      : transporter
                          .map((item) => DropdownMenuItem<String>(
                                value: item.transporterId,
                                child: Text(
                                  item.name!,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ))
                          .toList()),
              RSizedBox(height: 15.h),
              Text(
                "Route Name",
                style: TextStyle(fontSize: 16.sp),
              ),
              TxtField(
                controller: namecontroller,
                hintText: "Name",
                fillColor: Colors.transparent,
              ),
              RSizedBox(height: 10.h),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: routeValue.length,
                  // ref
                  //     .watch(subDairyProvider.notifier)
                  //     .sub_dairy_length(),
                  itemBuilder: (context, index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Dairy",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          CtmDropDown(
                              inisialvalue: null,
                              onChanged: (value) {
                                ref
                                    .read(subDairyProvider.notifier)
                                    .onchange_list(value);
                                setState(() {});

                                print("route lst  :: $routeValue");
                              },
                              hintTxt:
                                  "${routeValue[index]!.userId == null ? 'Select Dairy' : "${routeValue[index]!.name} - ${routeValue[index]!.roleName}"} ",
                              lst: ref
                                          .watch(subDairyProvider.notifier)
                                          .lstshow() ==
                                      null
                                  ? []
                                  : ref
                                      .watch(subDairyProvider.notifier)
                                      .lstshow()
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item.userId,
                                            child: Text(item.name!,
                                                style:
                                                    TextStyle(fontSize: 14.sp)),
                                          ))
                                      .toList()),
                          RSizedBox(height: 15.h),
                        ]);
                  }),
              RSizedBox(height: 15.h),
              Row(
                children: [
                  Expanded(
                      child: buttonContainer(
                          onTap: () {
                            ref.read(subDairyProvider.notifier).remove_route();
                            setState(() {});
                          },
                          color: AppColor.redClr,
                          txt: "Remove")),
                  SizedBox(width: 10.h),
                  Expanded(
                      child: buttonContainer(
                          onTap: () {
                            if (typeValue == "") {
                              snackBarMessage(
                                  msg: "The selected transporter is invalid."
                                  );
                            } else if (namecontroller.text.isEmpty) {
                              snackBarMessage(
                                  msg: "The route name field is required."
                                 );
                            } else if (routeValue.length < 2) {
                              snackBarMessage(
                                  msg: "The dairy list field is required"
                                  );
                            } else {
                              if (widget.edit == true) {
                                ref.read(subDairyProvider.notifier).add_Route(
                                    true,
                                    route_id: widget.data!.routeId!,
                                    routeValue: routeValue,
                                    typeValue: typeValue,
                                    ctr: namecontroller);
                              } else {
                                ref.read(subDairyProvider.notifier).add_Route(
                                    false,
                                    routeValue: routeValue,
                                    typeValue: typeValue,
                                    ctr: namecontroller);
                              }
                            }
                          },
                          txt: "Submit"))
                ],
              ),
              RSizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}
