// ignore_for_file: use_build_context_synchronously

import 'package:mydairy/export.dart';
import 'package:flutter/material.dart';

final rateTypeProvider = StateProvider.autoDispose<int>((ref) => 0);
final generalInfoProvider = StateProvider.autoDispose<int>((ref) => 0);
final bonusDeductionProvider = StateProvider.autoDispose<int>((ref) => 0);
final milkBuyAdvanceProvider = StateProvider.autoDispose<bool>((ref) => false);
final siftProvider = StateProvider.autoDispose<int>((ref) => 0);
// final rateTypeSellProvider = StateProvider.autoDispose<int>((ref) => 0);
// final generalInfoSellProvider = StateProvider.autoDispose<int>((ref) => 0);
// final bonusDeductionsellProvider = StateProvider.autoDispose<int>((ref) => 0);
// final milkSellAdvanceProvider = StateProvider.autoDispose<bool>((ref) => false);
// final siftSellProvider = StateProvider.autoDispose<bool>((ref) => false);
final currentDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

// final selectDateMilkSellProvider =
//     StateNotifierProvider.autoDispose((ref) => DatepicNotifier(ref: ref));

final selectDateProvider =
    StateNotifierProvider.autoDispose((ref) => DatepicNotifier(ref: ref));
// final selectDate2Provider =
//     StateNotifierProvider.autoDispose((ref) => DatepicNotifier(ref: ref));
// final paymentScreenDateSelectProvider =
//     StateNotifierProvider.autoDispose((ref) => DatepicNotifier(ref: ref));
// final selectDateViewByEntryProvider = StateNotifierProvider.autoDispose((ref) {
//   return DatepicNotifier(ref: ref);
// });

class DatepicNotifier extends StateNotifier<String> {
  Ref ref;
  DateTime? pickTime;
  DatepicNotifier({required this.ref}) : super('');

  Future selectDate(BuildContext context) async {
    try {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: pickTime ?? DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
      );

      if (pickedDate != null) {
        state = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
        print("PIC    ${pickedDate}");
        pickTime = pickedDate;

        print("PIC time   ${pickTime}");

        snackBarMessage(msg: "Date Select $state", color: AppColor.greenClr);

        return state;
      }
      snackBarMessage(msg: "No Date Select");
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  void dispose() {
    state = '';
    super.dispose();
  }
}
