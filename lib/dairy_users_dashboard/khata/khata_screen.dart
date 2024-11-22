import 'package:flutter/material.dart';
import 'add_payment_screen.dart';
import 'package:mydairy/export.dart';

class KhataScreen extends StatefulWidget {
  const KhataScreen({super.key});

  @override
  State<KhataScreen> createState() => KhataScreenState();
}

class KhataScreenState extends State<KhataScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(":::?:::${_tabController.animation?.value}");

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.appColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Payment',
          style: TextStyle(
            color: AppColor.whiteClr,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          CustomAppBarBtn(
            title: _tabController.animation?.value == 0.0
                ? "Add Receive"
                : "Add Pay",
            onTap: () => navigationTo(const AddPaymentScreen()),
          )
        ],
        bottom: TabBar(
          indicatorPadding: EdgeInsets.only(bottom: 10.h),
          dividerColor: AppColor.whiteClr,
          unselectedLabelColor: AppColor.whiteClr,
          indicatorColor: AppColor.whiteClr,
          labelStyle: const TextStyle(color: AppColor.whiteClr),
          controller: _tabController,
          onTap: (value) {
            setState(() {
              _tabController.animation?.value;
            });
          },
          tabs: const <Widget>[
            Tab(text: "PAY"),
            Tab(text: "RECEIVE"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[const PayScreen(), Container()],
      ),
    );
  }
}

class PayScreen extends ConsumerStatefulWidget {
  const PayScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PayScreenState();
}

class _PayScreenState extends ConsumerState<PayScreen>
    with SingleTickerProviderStateMixin {
  // late Animation animation;
  // late AnimationController animationController;
  @override
  void dispose() {
    // animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0.r),
      child: Column(
        children: [
          const TxtField(
            prefixIcon: Icon(
              Icons.search,
              size: 30,
            ),
            hintText: "Search Here",
          ),
        ],
      ),
    );
  }
}
