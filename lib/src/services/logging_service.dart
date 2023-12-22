import 'package:logger/logger.dart';

class LoggingService {
  static final logger = Logger(
    filter: null,
    printer: PrettyPrinter(),
    output: null,
  );
}
