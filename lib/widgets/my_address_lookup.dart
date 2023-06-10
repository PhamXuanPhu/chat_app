import 'package:chat_app/services/loading_service.dart';
import 'package:chat_app/widgets/my_sizedbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../models/address.dart';
import '../models/select_item.dart';
import '../resources/country.dart';
import 'my_button.dart';
import 'my_lookup.dart';
import 'my_text_filed.dart';

class MyAddressLookup extends StatefulWidget {
  const MyAddressLookup(
      {super.key,
      required this.hintText,
      this.validator,
      this.address,
      required this.submit});

  final String hintText;
  final String? Function(String)? validator;
  final Address? address;
  final Function(Address) submit;

  @override
  State<MyAddressLookup> createState() => _MyAddressLookupState();
}

class _MyAddressLookupState extends State<MyAddressLookup> {
  Address address = Address();
  List<SelectItem> provinces = [];
  List<SelectItem> districts = [];
  List<SelectItem> wards = [];

  final controller = TextEditingController();
  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  final streetController = TextEditingController();
  final wardController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      controller.addListener(() => setState(() {}));
    }

    if (widget.address != null && widget.address!.street.isNotEmpty) {
      controller.text = widget.address!.address;
      address = widget.address!;
      loadInitList();
    }
  }

  Future<void> loadInitList() async {
    if (address.countryId.isNotEmpty && address.countryId == '190') {
      var result = await API().getProvinces();
      provinces.addAll(result);
    }
    if (address.provinceId.isNotEmpty) {
      var result = await API().getDistricts(address.provinceId);
      districts.addAll(result);
    }
    if (address.districtId.isNotEmpty) {
      var result = await API().getWards(address.districtId);
      wards.addAll(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        showDialog(context);
      },
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      readOnly: true,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value!);
        }
        return null;
      },
      style: TextStyle(
        fontSize: 15,
        color: Theme.of(context).selectedRowColor,
        overflow: TextOverflow.ellipsis,
      ),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
          hintText: widget.hintText,
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    address = Address();
                    renderAddress();
                    controller.clear();
                    provinceController.clear();
                    districtController.clear();
                    streetController.clear();
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Theme.of(context).selectedRowColor,
                    size: 20,
                  ),
                  splashRadius: 10,
                ),
          filled: true,
          fillColor: Theme.of(context).toggleableActiveColor,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).toggleableActiveColor),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).toggleableActiveColor),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).toggleableActiveColor),
              borderRadius: BorderRadius.circular(10))),
      maxLines: 1,
    );
  }

  void showDialog(BuildContext context) {
    showBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(40),
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).toggleableActiveColor,
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, -2),
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.hintText),
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    splashRadius: 1,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.cancel_outlined,
                                      size: 20,
                                    )),
                              )
                            ],
                          ),
                          height10(value: 20),
                          title('quoc_gia'.tr()),
                          MyLookup(
                            listItem: Country.countries,
                            hintText: 'chon_quoc_gia'.tr(),
                            selectItem: SelectItem(
                                id: address.countryId,
                                name: address.countryName),
                            selected: (value) async {
                              if (value.id != address.countryId) {
                                Loading.show(context);
                                address.countryId = value.id;
                                address.countryName = value.name;

                                await loadProvinces();
                                await loadDistricts();
                                await loadWards();

                                streetController.clear();
                                address.street = '';
                                renderAddress();
                                Loading.hide();
                              }
                            },
                          ),
                          height10(),
                          title('tinh_thanh'.tr()),
                          MyLookup(
                            listItem: provinces,
                            hintText: 'chon_tinh_thanh'.tr(),
                            controller: provinceController,
                            selectItem: SelectItem(
                                id: address.provinceId,
                                name: address.provinceName),
                            selected: (value) async {
                              if (value.id != address.provinceId) {
                                Loading.show(context);
                                address.provinceId = value.id;
                                address.provinceName = value.name;

                                await loadDistricts();
                                await loadWards();

                                streetController.clear();
                                address.street = '';
                                renderAddress();
                                Loading.hide();
                              }
                            },
                          ),
                          height10(),
                          title('quan_huyen'.tr()),
                          MyLookup(
                            listItem: districts,
                            hintText: 'chon_quan_huyen'.tr(),
                            controller: districtController,
                            selectItem: SelectItem(
                                id: address.districtId,
                                name: address.districtName),
                            selected: (value) async {
                              if (value.id != address.districtId) {
                                Loading.show(context);
                                address.districtId = value.id;
                                address.districtName = value.name;

                                await loadWards();

                                streetController.clear();
                                address.street = '';
                                renderAddress();
                                Loading.hide();
                              }
                            },
                          ),
                          title('xa_phuong'.tr()),
                          MyLookup(
                            listItem: wards,
                            hintText: 'chon_xa_phuong'.tr(),
                            controller: wardController,
                            selectItem: SelectItem(
                                id: address.wardId, name: address.wardName),
                            selected: (value) {
                              if (value.id != address.wardId) {
                                address.wardId = value.id;
                                address.wardName = value.name;

                                streetController.clear();
                                address.street = '';
                                renderAddress();
                              }
                            },
                          ),
                          height10(),
                          title('so_nha_duong'.tr()),
                          MyTextField(
                            hintText: 'nhap_so_nha_duong'.tr(),
                            controller: streetController,
                            onChanged: (value) {
                              address.street = value;
                            },
                            text: address.street,
                          ),
                          height10(),
                          myButton(
                            'hoan_thanh'.tr(),
                            () async {
                              renderAddress();
                              Navigator.pop(context);
                            },
                          ),
                          height10(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> loadProvinces() async {
    provinceController.clear();
    address.provinceId = '';
    address.provinceName = '';
    if (address.countryId.isNotEmpty && address.countryId == '190') {
      var result = await API().getProvinces();
      provinces.addAll(result);
    } else {
      provinces.clear();
    }
  }

  Future<void> loadDistricts() async {
    districtController.clear();
    address.districtId = '';
    address.districtName = '';
    if (address.provinceId.isNotEmpty) {
      var result = await API().getDistricts(address.provinceId);
      districts.addAll(result);
    } else {
      districts.clear();
    }
  }

  Future<void> loadWards() async {
    wardController.clear();
    address.wardId = '';
    address.wardName = '';
    if (address.districtId.isNotEmpty) {
      var result = await API().getWards(address.districtId);
      wards.addAll(result);
    } else {
      wards.clear();
    }
  }

  void renderAddress() {
    widget.submit(address);

    List<String> listAddress = [];
    if (address.street.isNotEmpty) {
      listAddress.add(address.street);
    }
    if (address.wardName.isNotEmpty) {
      listAddress.add(address.wardName);
    }
    if (address.districtName.isNotEmpty) {
      listAddress.add(address.districtName);
    }
    if (address.provinceName.isNotEmpty) {
      listAddress.add(address.provinceName);
    }
    if (address.countryName.isNotEmpty) {
      listAddress.add(address.countryName);
    }

    address.address = listAddress.join(', ');
    controller.text = address.address;
  }

  Widget title(String text) => Container(
        padding: const EdgeInsets.all(5),
        child: Text(text),
      );

  @override
  void dispose() {
    controller.dispose();
    provinceController.dispose();
    districtController.dispose();
    streetController.dispose();
    wardController.dispose();
    super.dispose();
  }
}
