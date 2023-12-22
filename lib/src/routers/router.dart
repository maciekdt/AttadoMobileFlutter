import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/contacts_service.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/services/folders_service.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:attado_mobile/src/services/users_service.dart';
import 'package:attado_mobile/src/ui/common/navigations/scaffold_with_bottom_navigation.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:attado_mobile/src/ui/common/related/rel_contacts_page.dart';
import 'package:attado_mobile/src/ui/common/related/rel_folders_page.dart';
import 'package:attado_mobile/src/ui/common/related/rel_tasks_page.dart';
import 'package:attado_mobile/src/ui/common/search/my_filters_search_page.dart';
import 'package:attado_mobile/src/ui/pages/contacts/filter/search_pages/contact_type_search_page.dart';
import 'package:attado_mobile/src/ui/pages/contacts/filter/tab/contacts_filtering_tab.dart';
import 'package:attado_mobile/src/ui/pages/documents/filter/search_pages/document_state_search_page.dart';
import 'package:attado_mobile/src/ui/pages/documents/filter/search_pages/document_type_search_page.dart';
import 'package:attado_mobile/src/ui/pages/documents/filter/search_pages/file_type_search_page.dart';
import 'package:attado_mobile/src/ui/common/search/system_filter_search_page.dart';
import 'package:attado_mobile/src/ui/common/search/users_search_page.dart';
import 'package:attado_mobile/src/ui/pages/contacts/contact_details/contact_tab.dart';
import 'package:attado_mobile/src/ui/pages/contacts/list/contacts_list_page.dart';
import 'package:attado_mobile/src/ui/pages/documents/document_details/document_tab.dart';
import 'package:attado_mobile/src/ui/common/related/rel_documents_page.dart';
import 'package:attado_mobile/src/ui/pages/documents/filter/tab/documents_filtering_tab.dart';
import 'package:attado_mobile/src/ui/pages/documents/list/documents_list_page.dart';
import 'package:attado_mobile/src/ui/pages/folders/filter/search_pages/folder_status_search_page.dart';
import 'package:attado_mobile/src/ui/pages/folders/filter/search_pages/folder_type_search_page.dart';
import 'package:attado_mobile/src/ui/pages/folders/filter/tab/folders_filtering_tab.dart';
import 'package:attado_mobile/src/ui/pages/folders/folder_details/folder_tab.dart';
import 'package:attado_mobile/src/ui/pages/folders/list/folders_list_page.dart';
import 'package:attado_mobile/src/ui/pages/login/start_loading_page.dart';
import 'package:attado_mobile/src/ui/pages/login/login_page.dart';
import 'package:attado_mobile/src/ui/pages/settings/settings_page.dart';
import 'package:attado_mobile/src/ui/pages/tasks/filter/search_pages/task_priorities_search_page.dart';
import 'package:attado_mobile/src/ui/pages/tasks/filter/search_pages/task_status_search_page.dart';
import 'package:attado_mobile/src/ui/pages/tasks/filter/search_pages/task_type_search_page.dart';
import 'package:attado_mobile/src/ui/pages/tasks/filter/tab/tasks_filtering_tab.dart';
import 'package:attado_mobile/src/ui/pages/tasks/list/tasks_list_page.dart';
import 'package:attado_mobile/src/ui/pages/tasks/task_details/task_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKeyDocuments =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKeySettings =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKeyFolders =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKeyContacts =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKeyTasks =
    GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/startloading',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithBottomNavigation(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyDocuments,
          routes: [
            GoRoute(
              path: '/documents',
              pageBuilder: (context, state) {
                Provider.of<AppProvider>(context).showBottomNavigation = true;
                return NoTransitionPage(
                  key: state.pageKey,
                  child: DocumentsListPage(
                    service: getIt<DocumentsService>(),
                    authRepo: getIt<AuthRepo>(),
                  ),
                );
              },
              routes: [
                GoRoute(
                    path: 'details',
                    pageBuilder: (context, state) {
                      Provider.of<AppProvider>(context).showBottomNavigation =
                          true;
                      return NoTransitionPage(
                        key: state.pageKey,
                        child: DocumentTab(
                          document: state.extra as Document,
                          documentsService: getIt<DocumentsService>(),
                        ),
                      );
                    }),
                GoRoute(
                  path: 'filter',
                  pageBuilder: (context, state) {
                    Provider.of<AppProvider>(context).showBottomNavigation =
                        false;
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: DocumentsFilteringTab(
                        documentsService: getIt<DocumentsService>(),
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'document-type',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: DocumentTypeSearchPage(
                          documentsService: getIt<DocumentsService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'file-type',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: FileTypeSearchPage(
                          documentsService: getIt<DocumentsService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'my-filter',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: MyFilterSearchPage(
                          service: getIt<DocumentsService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'state/:documentTypeId',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: DocumentStateSearchPage(
                          documentsService: getIt<DocumentsService>(),
                          documentTypeId: int.parse(
                              state.pathParameters['documentTypeId'] as String),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'system-filter',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: SystemFilterSearchPage(
                          service: getIt<DocumentsService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'my-filter',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: MyFilterSearchPage(
                          service: getIt<DocumentsService>(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyFolders,
          routes: [
            GoRoute(
              path: '/folders',
              pageBuilder: (context, state) {
                Provider.of<AppProvider>(context).showBottomNavigation = true;
                return NoTransitionPage(
                  key: state.pageKey,
                  child: FoldersListPage(
                    foldersService: getIt<FoldersService>(),
                    authRepo: getIt<AuthRepo>(),
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: 'details',
                  pageBuilder: (context, state) {
                    Provider.of<AppProvider>(context).showBottomNavigation =
                        true;
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: FolderTab(
                        folder: state.extra as Folder,
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: 'filter',
                  pageBuilder: (context, state) {
                    Provider.of<AppProvider>(context).showBottomNavigation =
                        false;
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: const FoldersFilteringTab(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'type',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: FolderTypeSearchPage(
                          foldersService: getIt<FoldersService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'status/:folderTypeId',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: FolderStatusSearchPage(
                          foldersService: getIt<FoldersService>(),
                          folderTypeId: int.parse(
                              state.pathParameters['folderTypeId'] as String),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'my-filter',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: MyFilterSearchPage(
                          service: getIt<FoldersService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'system-filter',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: SystemFilterSearchPage(
                          service: getIt<FoldersService>(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyContacts,
          routes: [
            GoRoute(
              path: '/contacts',
              pageBuilder: (context, state) {
                Provider.of<AppProvider>(context).showBottomNavigation = true;
                return NoTransitionPage(
                  key: state.pageKey,
                  child: ContactsListPage(
                    contactsService: getIt<ContactsService>(),
                    authRepo: getIt<AuthRepo>(),
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: 'filter',
                  pageBuilder: (context, state) {
                    Provider.of<AppProvider>(context).showBottomNavigation =
                        false;
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: const ContactsFilteringTab(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'type',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: ContactTypeSearchPage(
                          contactsService: getIt<ContactsService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'my-filter',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: MyFilterSearchPage(
                          service: getIt<ContactsService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'system-filter',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: SystemFilterSearchPage(
                          service: getIt<ContactsService>(),
                        ),
                      ),
                    ),
                  ],
                ),
                GoRoute(
                    path: 'details',
                    pageBuilder: (context, state) {
                      Provider.of<AppProvider>(context).showBottomNavigation =
                          true;
                      return NoTransitionPage(
                        key: state.pageKey,
                        child: ContactTab(
                          contact: state.extra as Contact,
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyTasks,
          routes: [
            GoRoute(
              path: '/tasks',
              pageBuilder: (context, state) {
                Provider.of<AppProvider>(context).showBottomNavigation = true;
                return NoTransitionPage(
                  key: state.pageKey,
                  child: TasksListPage(
                    tasksService: getIt<TasksService>(),
                    authRepo: getIt<AuthRepo>(),
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: 'filter',
                  pageBuilder: (context, state) {
                    Provider.of<AppProvider>(context).showBottomNavigation =
                        false;
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: const TasksFilteringTab(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'type',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: TaskTypeSearchPage(
                          tasksService: getIt<TasksService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'status',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: TaskStatusSearchPage(
                          tasksService: getIt<TasksService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'priority',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: TaskPrioritiesSearchPage(
                          tasksService: getIt<TasksService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'my-filter',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: MyFilterSearchPage(
                          service: getIt<TasksService>(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: 'system-filter',
                      pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: SystemFilterSearchPage(
                          service: getIt<TasksService>(),
                        ),
                      ),
                    ),
                  ],
                ),
                GoRoute(
                    path: 'details',
                    pageBuilder: (context, state) {
                      Provider.of<AppProvider>(context).showBottomNavigation =
                          true;
                      return NoTransitionPage(
                        key: state.pageKey,
                        child: TaskTab(
                          task: state.extra as Task,
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeySettings,
          routes: [
            GoRoute(
              path: '/settings',
              pageBuilder: (context, state) {
                Provider.of<AppProvider>(context).showBottomNavigation = true;
                return NoTransitionPage(
                  key: state.pageKey,
                  child: SettingsPage(
                    authRepo: getIt<AuthRepo>(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/search/user',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: UsersSearchPage(
          usersService: getIt<UsersService>(),
        ),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(
        authRepo: getIt<AuthRepo>(),
      ),
    ),
    GoRoute(
      path: '/startloading',
      builder: (context, state) => StartLoadingPage(
        authRepo: getIt<AuthRepo>(),
      ),
    ),
    GoRoute(
      path: '/rel-documents',
      pageBuilder: (context, state) {
        final Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
        return NoTransitionPage(
          key: state.pageKey,
          child: RelDocumentsPage(
            documents: extras['documents'],
            title: extras['title'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/rel-folders',
      pageBuilder: (context, state) {
        final Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
        return NoTransitionPage(
          key: state.pageKey,
          child: RelFoldersPage(
            folders: extras['folders'],
            title: extras['title'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/rel-contacts',
      pageBuilder: (context, state) {
        final Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
        return NoTransitionPage(
          key: state.pageKey,
          child: RelContactsPage(
            contacts: extras['contacts'],
            title: extras['title'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/rel-tasks',
      pageBuilder: (context, state) {
        final Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
        return NoTransitionPage(
          key: state.pageKey,
          child: RelTasksPage(
            tasks: extras['tasks'],
            title: extras['title'],
          ),
        );
      },
    ),
  ],
);
