extension StringExt on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get obscureEmailText {
    final index = indexOf('@');
    var userName = substring(0, index);
    final domain = substring(index + 1);

    userName = '${userName[0]}********${userName.length - 1}';
    return '$userName@$domain';
  }
}
