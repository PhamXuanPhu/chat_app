import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../api/firebase.dart';
import '../../blocs/user/user_bloc.dart';
import '../../services/loading_service.dart';
import '../../services/toast_service.dart';
import '../../widgets/my_button.dart';

class ChangeAvatarScreen extends StatefulWidget {
  const ChangeAvatarScreen({super.key});

  @override
  State<ChangeAvatarScreen> createState() => _ChangeAvatarScreenState();
}

class _ChangeAvatarScreenState extends State<ChangeAvatarScreen> {
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<UserBloc>(context);

    return BlocBuilder<UserBloc, UserState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: ClipOval(
                    child: file != null && file!.path != null
                        ? Image.file(
                            File(file!.path!),
                          )
                        : Image.network(
                            state.currentUser.avatar,
                            height: 100,
                            width: 100,
                          ),
                  ),
                ),
                myButton('Selec file', () async {
                  PermissionStatus status = await Permission.storage.request();
                  if (status.isDenied) {
                    // ignore: use_build_context_synchronously
                    Toast.message(
                        context: context, message: 'Quyền truy cập bị từ chối');
                  } else if (status.isPermanentlyDenied) {
                    // ignore: use_build_context_synchronously
                    Toast.message(
                        context: context,
                        message: 'Quyền truy cập bị từ chối vĩnh viễn');
                  } else if (status.isGranted) {
                    final result = await FilePicker.platform
                        .pickFiles(allowMultiple: false);
                    if (result == null) return;
                    setState(() {
                      file = result.files.first;
                    });
                  }
                }),
                myButton('Upload', () async {
                  Loading.show(context);
                  if (file != null) {
                    var result =
                        await FirebaseAPI.updateAvatar(File(file!.path!));
                    if (result.isNotEmpty) {
                      bloc.add(UpdateAvatar(newData: result));
                      // ignore: use_build_context_synchronously
                      Toast.message(
                          context: context,
                          message: 'noti_thay_doi_thong_tin_thanh_cong'.tr());
                    }
                  }
                  Loading.hide();
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
