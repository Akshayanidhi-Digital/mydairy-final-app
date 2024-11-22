import 'package:flutter/material.dart';
import '../apis.dart';
import '../controller.dart';
import '../membership_src.dart';
import 'package:mydairy/export.dart';

import '../plan/plan_status_screen.dart';

class MemberShipScreen extends ConsumerWidget {
  const MemberShipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansBuild = ref.watch(plansApiProvider);
    final data = ref.watch(plandataProvider);

    return Scaffold(
      appBar: BaseAppBar(title: "Membership"),
      body: LoadingdataScreen(
        varBuild: plansBuild,
        data: (mydata) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(8.0.r),
                child: MemberPurchageSrc(
                    elevetion: true,
                    color: Color(index % 3 == 0
                        ? 0xff1E0101
                        : index % 2 == 0
                            ? 0xff2C7C36
                            : 0xff273C75),
                    inerColor: Color(index % 3 == 0
                        ? 0xffFF0000
                        : index % 2 == 0
                            ? 0xff3EBA55
                            : 0xff192A56),
                    price: data[index].price.toString(),
                    validity:
                        "${data[index].duration.toString()} ${data[index].durationType.toString()}",
                    validity2: data[index].category.toString(),
                    onTap: () {
                      navigationTo(PlanStatusScreen(
                          data: data[index],
                          id: data[index].planId.toString()));
                      // ref.read(planStatusProvider.notifier).state = data[index];
                    }),
              ),
            )),
      ),
    );
  }
}
