class NoMobileLicenseException implements Exception {
  NoMobileLicenseException({this.status});
  int? status;
}
