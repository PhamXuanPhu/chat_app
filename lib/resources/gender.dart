import 'package:easy_localization/easy_localization.dart';

import '../models/select_item.dart';

class Gender {
  Gender._();
  static List<SelectItem> genders = [
    SelectItem(id: '0', name: 'nam'.tr()),
    SelectItem(id: '1', name: 'nu'.tr()),
    SelectItem(id: '2', name: 'khac'.tr()),
  ];
}
