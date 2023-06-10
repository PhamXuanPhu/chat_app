import 'package:easy_localization/easy_localization.dart';

import '../models/select_item.dart';

class Gender {
  Gender._();
  static List<SelectItem> genders = [
    SelectItem(id: '0', name: 'nam'.tr()),
    SelectItem(id: '1', name: 'nu'.tr()),
    SelectItem(id: '2', name: 'khac'.tr()),
  ];
  static SelectItem? getGenderWithID(String id) {
    if (id.isEmpty) return null;
    var item = genders.firstWhere((item) => item.id == id);
    if (item.id != '') {
      return item;
    }
    return null;
  }
}
