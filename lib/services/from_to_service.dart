import 'package:chat_app/configs/config.dart';
import 'package:chat_app/models/user.dart';

User toUser(List<dynamic> members) {
  if (members.isNotEmpty && members.length == 2) {
    if (User.fromMap(members[0]).id != Config.user.id) {
      return User.fromMap(members[0]);
    }
    return User.fromMap(members[1]);
  }
  throw ('Error');
}

bool getStatus(Map<String, dynamic> online, String toId) {
  try {
    if (online[toId] != null) {
      return online[toId];
    } else {
      return false;
    }
  } catch (e) {
    throw Exception(e);
  }
}
