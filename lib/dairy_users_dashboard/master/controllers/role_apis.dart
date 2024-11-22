import 'package:mydairy/dairy_users_dashboard/master/controllers/role_controller.dart';
import 'package:mydairy/dairy_users_dashboard/model/help_model.dart';

import '../../../export.dart';
import '../rules_permission/permission_src.dart';

Map permission = {};

final rulesApiProvider = Provider.autoDispose<RulesApi>((ref) => RulesApi(ref));

class RulesApi {
  Ref ref;
  RulesApi(this.ref);
  Future rulesGetApi() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.rulesGet);
    if (response.success == true) {
      return response.data;
    } else if (response.success == false) {
      return errorSnacMsg(response);
    }
  }

  Future roleViewGetApi(id) async {
    Map data = {'role_id': id};
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.roleViewGet, data: data);
    if (response.success == true) {
      permission = response.data;
      print("permission::::::::::::::::=>   $permission");

      return response.data;
    } else if (response.success == false) {
      return errorSnacMsg(response);
    }
  }

  Future rulesUpdate(Map data) async {
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.rulesUpdate, data: data);
    if (response.success == true) {
      print("permission::::::::::::::::=>   $permission");
      successMsg(response);
      permissionList.clear();
      return response.data;
    } else if (response.success == false) {
      return errorSnacMsg(response);
    }
  }

  Future helpApi() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.dairy_help);
    if (response.success == true) {
      for (int i = 0; i < response.data.length; i++) {
        ref
            .read(helpdataProvider.notifier)
            .state
            .add(HelpModel.fromJson(response.data[i]));
      }
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}
