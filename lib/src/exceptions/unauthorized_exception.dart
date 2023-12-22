class UnauthorizedException implements Exception {
  UnauthorizedException({this.status});
  int? status;
}
