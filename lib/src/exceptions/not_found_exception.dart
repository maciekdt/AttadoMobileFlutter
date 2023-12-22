class NotFoundException implements Exception {
  NotFoundException({this.status});
  int? status;
}
