class InternalServerException implements Exception {
  InternalServerException({required this.status});
  int status;
}
