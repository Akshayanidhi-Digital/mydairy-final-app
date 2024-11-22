import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

import '../milk_buy_sell/milk_buy_controller.dart';

final paymenttxtProvider = StateProvider.autoDispose<int>((ref) => 0);

class AddPaymentScreen extends ConsumerStatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddPaymentScreenState();
}

class _AddPaymentScreenState extends ConsumerState<AddPaymentScreen> {
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dateSelect = ref.watch(selectDateProvider);
    final now = ref.watch(currentDateProvider);
    final paymenttxtBuild = ref.watch(paymenttxtProvider);
    final uploadFile = ref.watch(imageProvider);
    return Scaffold(
        appBar: BaseAppBar(
          title: "Payment",
          actionList: const [CustomAppBarBtn()],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RSizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TxtField(
                          readOnly: true,
                          onTap: () => ref
                              .read(selectDateProvider.notifier)
                              .selectDate(context),
                          hintText:
                              "${dateSelect == "" ? " ${now.day}-${now.month}-${now.year}" : dateSelect}",
                          suffixIcon: const Image(
                              image: AssetImage(Img.calenderImage))),
                    ),
                    RSizedBox(width: 10.w),
                    const Expanded(
                      child: TxtField(hintText: "Reference No"),
                    ),
                  ],
                ),
              const  Text(
                  "Select",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColor.blackClr,
                      fontWeight: FontWeight.w500),
                ),
                RSizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        paymentTxt.length,
                        (index) => Expanded(
                              child: RadioListTile(
                                activeColor: AppColor.appColor,
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text(paymentTxt[index].txt),
                                value: index,
                                groupValue: paymenttxtBuild,
                                onChanged: (value) {
                                  ref.read(paymenttxtProvider.notifier).state =
                                      value!;
                                },
                              ),
                            )),
                  ),
                ),
                RSizedBox(height: 10.h),
                dropdownBtn(
                  bydefalutselect: "Select Customer",
                  value: '',
                  listitem: [],
                  onChanged: (value) {},
                ),
                RSizedBox(height: 10.h),
                TxtField(hintText: "Amount", controller: amountController),
                RSizedBox(height: 10.h),
                if (paymenttxtBuild == 1)
                  Column(
                    children: [
                      const TxtField(hintText: "Bank Name"),
                      RSizedBox(height: 10.h),
                      const TxtField(hintText: "Account No."),
                      RSizedBox(height: 10.h),
                    ],
                  ),
                if (paymenttxtBuild == 2)
                  Column(
                    children: [
                      const TxtField(hintText: "Cheque No"),
                      RSizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          ref.read(imageUploaderProvider.notifier);
                        },
                        child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                                border: const Border(
                                    bottom: BorderSide(color: AppColor.grey)),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.w),
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    uploadFile == null
                                        ? "Please Upload Image File"
                                        : uploadFile.toString().split('/').last,
                                    style: TextStyle(fontSize: 14.w),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(right: 15.w),
                                    child: Image(
                                        image: const AssetImage(Img.img_upload),
                                        color: AppColor.blackClr,
                                        width: 20.w))
                              ],
                            )),
                      ),
                      RSizedBox(height: 10.h),
                    ],
                  ),
                TxtField(
                    hintText: "Description", controller: descriptionController),
                RSizedBox(height: 20.h),
                buttonContainer(txt: "Submit", width: double.infinity)
              ],
            ),
          ),
        ));
  }
}
