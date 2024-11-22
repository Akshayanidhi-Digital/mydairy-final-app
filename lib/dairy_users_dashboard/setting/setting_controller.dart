import 'package:flutter_riverpod/flutter_riverpod.dart';

final defaultValueprovider = StateProvider.autoDispose<String>((ref) => '');
final dropDownListDataprovider = StateProvider.autoDispose<List>((ref) => [
      {"title": "English", "value": "1"},
      {"title": "Hindi", "value": "2"},
    ]);

final fontSizeProvider = StateProvider.autoDispose((ref) => 'N');
final selectPrinterProvider = StateProvider.autoDispose((ref) => '2');
final weightProvider = StateProvider.autoDispose((ref) => 'W');

class SettingModel {
  int? id;
  String? userId;
  String? lang;
  String? printFontSize;
  String? wight;
  String? printSize;
  int? printRecipt;
  int? printReciptAll;
  int? whatsappMessage;
  int? autoFats;
  int? rateParKg;
  int? fatRate;
  int? snf;
  int? bonus;
  String? createdAt;
  String? updatedAt;

  SettingModel(
      {this.id,
      this.userId,
      this.lang,
      this.printFontSize,
      this.wight,
      this.printSize,
      this.printRecipt,
      this.printReciptAll,
      this.whatsappMessage,
      this.autoFats,
      this.rateParKg,
      this.fatRate,
      this.snf,
      this.bonus,
      this.createdAt,
      this.updatedAt});

  SettingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lang = json['lang'];
    printFontSize = json['print_font_size'];
    wight = json['wight'];
    printSize = json['print_size'];
    printRecipt = json['print_recipt'];
    printReciptAll = json['print_recipt_all'];
    whatsappMessage = json['whatsapp_message'];
    autoFats = json['auto_fats'];
    rateParKg = json['rate_par_kg'];
    fatRate = json['fat_rate'];
    snf = json['snf'];
    bonus = json['bonus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['lang'] = this.lang;
    data['print_font_size'] = this.printFontSize;
    data['wight'] = this.wight;
    data['print_size'] = this.printSize;
    data['print_recipt'] = this.printRecipt;
    data['print_recipt_all'] = this.printReciptAll;
    data['whatsapp_message'] = this.whatsappMessage;
    data['auto_fats'] = this.autoFats;
    data['rate_par_kg'] = this.rateParKg;
    data['fat_rate'] = this.fatRate;
    data['snf'] = this.snf;
    data['bonus'] = this.bonus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
