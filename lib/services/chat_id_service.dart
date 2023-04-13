String chatID(String id1, String id2) {
  if (id1.compareTo(id2) > 0) {
    return '$id1$id2';
  } else {
    return '$id2$id1';
  }
}
