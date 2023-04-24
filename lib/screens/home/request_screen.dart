import 'package:chat_app/services/current_user_service.dart';
import 'package:chat_app/widgets/user_itemtemplate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/firebase.dart';
import '../../blocs/user/user_bloc.dart';
import '../../models/user.dart';
import '../../services/loading_service.dart';
import '../../widgets/add_friend_itemtemplate.dart';
import '../../widgets/textfield_search.dart';

// Widget requests() => Padding(
//       padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//       child: StreamBuilder(
//           stream: FirebaseAPI.getFriendRequests(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               List<User> friendRequests =
//                   snapshot.data!.docs.map((doc) => doc.data()).toList();

//               return ListView.builder(
//                 itemCount: friendRequests.length,
//                 itemBuilder: (context, index) {
//                   return addFriendItemTemplate(
//                       user: friendRequests[index],
//                       onPressed: (value) async {
//                         Loading().show();
//                         bool result = await FirebaseAPI.confirmAddFriend(
//                             friendRequests[index], value);
//                         if (result) {
//                           // add id for load users
//                           CurrentUser.user.friend_array
//                               .add(friendRequests[index].id);
//                         }
//                         CurrentUser.user.friend_request_array
//                             .remove(friendRequests[index].id);
//                         Loading().hide();
//                       });
//                 },
//               );
//             }

//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }),
//     );

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);
    FirebaseAPI.getRequests(bloc);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: BlocBuilder<UserBloc, UserState>(
          bloc: bloc,
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.requests.length,
              itemBuilder: (context, index) {
                return addFriendItemTemplate(
                    user: state.requests[index],
                    onPressed: (value) async {
                      Loading().show();
                      bool result = await FirebaseAPI.confirmRequest(
                          state.requests[index].id, value);
                      Loading().hide();
                    });
              },
            );
          }),
    );
  }
}
