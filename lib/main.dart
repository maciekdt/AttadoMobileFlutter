import 'dart:io';

import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/app.dart';
import 'package:attado_mobile/src/services/notifications_service.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:flutter/material.dart';

void main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await NotyficationsService.initFirebaseApp();
    await NotyficationsService.setUpNotyficationsHandlers();
  }

  final AppProvider appProvider = AppProvider();
  await appProvider.setThemeFromStorage();

  runApp(App(appProvider: appProvider));
}
