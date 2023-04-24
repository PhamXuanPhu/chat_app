extension FirestoreService on String {
  List<String> get nameToArray {
    List<String> name = split(' ');
    List<String> arr = [];
    for (var element in name) {
      for (int i = 0; i < element.length; i++) {
        arr.add(element.substring(0, i + 1).toLowerCase());
      }
    }
    return arr;
  }
}
