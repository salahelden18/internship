String getNameFromEmail(String email) {
  String firstPart = email.split('@')[0];
  String fullName = firstPart
      .split('.')
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join(' ');

  return fullName;
}
