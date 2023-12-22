// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/services/notifications_service.dart';
import 'package:attado_mobile/src/ui/common/exceptions/client_exception_page.dart';
import 'package:attado_mobile/src/ui/common/exceptions/offline_exception_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class StartLoadingPage extends StatefulWidget {
  StartLoadingPage({super.key, required this.authRepo});
  final AuthRepo authRepo;
  final NotyficationsService notificationsService =
      getIt<NotyficationsService>();
  final DocumentsService documentsService = getIt<DocumentsService>();

  @override
  State<StartLoadingPage> createState() => _StartLoadingPageState();
}

class _StartLoadingPageState extends State<StartLoadingPage> {
  final LocalAuthentication _localAuthService = LocalAuthentication();
  bool _offlineException = false;
  bool _loginException = false;

  @override
  void initState() {
    super.initState();
    _login();
  }

  Future<void> _login() async {
    try {
      if (await widget.authRepo.loginFromStorage()) {
        if (Platform.isAndroid) {
          await widget.notificationsService.registerApp();
        }
        if (await widget.authRepo.getBiometricAuthFromSecureStorage()) {
          await _localAuth();
        } else {
          _goToMainPage();
        }
      } else {
        _goToLoginPage();
      }
    } on SocketException catch (_) {
      setState(() {
        _offlineException = true;
      });
    } catch (e) {
      _goToLoginPage();
    }
  }

  void _goToLoginPage() {
    context.go('/login');
  }

  void _goToMainPage() async {
    if (Platform.isAndroid &&
        await widget.notificationsService.isAppStartedFromNotification()) {
      try {
        await widget.notificationsService.redirectFromInitNotification();
      } catch (_) {
        context.go('/documents');
      }
    } else {
      context.go('/documents');
    }
  }

  Future<void> _localAuth() async {
    try {
      final bool didAuthenticate = await _localAuthService.authenticate(
          localizedReason: 'Zaloguj się do aplikacji',
          options: const AuthenticationOptions(useErrorDialogs: true));
      if (didAuthenticate) {
        _goToMainPage();
      } else {
        _goToLoginPage();
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        _goToMainPage();
      } else if (e.code == auth_error.notEnrolled) {
        _goToMainPage();
      } else {
        _goToLoginPage();
      }
    }
  }

  void _refresh() {
    setState(() {
      _loginException = false;
      _offlineException = false;
      _login();
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_loginException
        ? !_offlineException
            ? Scaffold(
                backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                body: const Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 30),
                            child: Image(
                              image: AssetImage('assets/logo.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : OfflineExceptionPage(onRefresh: _refresh)
        : ClientExceptionPage(onRefresh: _refresh);
  }
}
