import 'package:attado_mobile/src/routers/router.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:attado_mobile/src/ui/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.appProvider,
  });

  final AppProvider appProvider;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<AppProvider>(
          create: (_) => widget.appProvider,
        ),
      ],
      child: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return MaterialApp.router(
            theme: provider.darkTheme ? AppTheme.dark : AppTheme.light,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
