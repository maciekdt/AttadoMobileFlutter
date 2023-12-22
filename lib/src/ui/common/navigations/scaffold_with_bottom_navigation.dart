import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:attado_mobile/src/ui/pages/contacts/providers/contacts_options_provider.dart';
import 'package:attado_mobile/src/ui/pages/documents/providers/documents_options_provider.dart';
import 'package:attado_mobile/src/ui/pages/documents/providers/selected_documents_provider.dart';
import 'package:attado_mobile/src/ui/pages/folders/providers/folders_options_provider.dart';
import 'package:attado_mobile/src/ui/pages/tasks/providers/tasks_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ScaffoldWithBottomNavigation extends StatefulWidget {
  const ScaffoldWithBottomNavigation({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<StatefulWidget> createState() => _ScaffoldWithBottomNavigationState();
}

class _ScaffoldWithBottomNavigationState
    extends State<ScaffoldWithBottomNavigation> {
  late AppProvider _appProvider;

  void _goBranch(int index) {
    if (index == 0) {
      context.go('/documents');
    } else if (index == 1) {
      context.go('/folders');
    } else if (index == 2) {
      context.go('/contacts');
    } else if (index == 3) {
      context.go('/tasks');
    } else if (index == 4) {
      context.go('/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    _appProvider = Provider.of<AppProvider>(context, listen: true);
    return MultiProvider(
      providers: [
        ListenableProvider<DocumentsOptionsProvider>(
          create: (_) => DocumentsOptionsProvider(),
        ),
        ListenableProvider<SelectedDocumentsProvider>(
          create: (_) => SelectedDocumentsProvider(),
        ),
        ListenableProvider<FoldersOptionsProvider>(
          create: (_) => FoldersOptionsProvider(),
        ),
        ListenableProvider<ContactsOptionsProvider>(
          create: (_) => ContactsOptionsProvider(),
        ),
        ListenableProvider<TasksOptionsProvider>(
          create: (_) => TasksOptionsProvider(),
        ),
      ],
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: _appProvider.showBottomNavigation
            ? BottomNavigationBar(
                currentIndex: widget.navigationShell.currentIndex,
                onTap: _goBranch,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.description_outlined),
                      label: 'eDokumenty'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.folder_outlined), label: 'eSprawy'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.contact_page_outlined),
                      label: 'eKontakty'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.task_alt), label: 'Zadania'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.manage_accounts_outlined),
                      label: 'Ustawienia'),
                ],
              )
            : null,
      ),
    );
  }
}
