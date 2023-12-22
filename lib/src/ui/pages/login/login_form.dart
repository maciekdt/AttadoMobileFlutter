// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/exceptions/no_mobile_license_exception.dart';
import 'package:attado_mobile/src/exceptions/unauthorized_exception.dart';
import 'package:attado_mobile/src/models/auth_models/auth_user.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/services/notifications_service.dart';
import 'package:attado_mobile/src/ui/common/toasts/toastification_controller.dart';
import 'package:attado_mobile/src/ui/pages/login/password_text_field.dart';
import 'package:attado_mobile/src/ui/strings/strings.dart';
import 'package:attado_mobile/src/ui/common/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.repo});
  final AuthRepo repo;

  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final NotyficationsService notyficationsService =
      getIt<NotyficationsService>();
  final TextEditingController _controllerServerAddress =
      TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.repo.serverUrl != null) {
      _controllerServerAddress.text = widget.repo.serverUrl!;
    } else {
      widget.repo.getServerUrlFromSecureStorage().then((url) {
        if (url != null) {
          _controllerServerAddress.text = url;
        }
      });
    }
  }

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      _onLoading();
      try {
        await widget.repo.login(
          AuthUser(
            username: _controllerUsername.text,
            password: _controllerPassword.text,
          ),
          _controllerServerAddress.text,
        );
        await _registerApp();
        _goToMainPage();
      } on UnauthorizedException {
        ToastifiationController.showTopNotification(
          context,
          "Niepoprawna nazwa użytkownika lub hasło",
          ToastificationType.error,
        );
      } on NoMobileLicenseException {
        ToastifiationController.showTopNotification(
          context,
          "Brak mobilnej licencji",
          ToastificationType.error,
        );
      } on SocketException {
        ToastifiationController.showTopNotification(
          context,
          "Brak połączenia z internetem lub serwerem",
          ToastificationType.error,
        );
      } on ArgumentError {
        ToastifiationController.showTopNotification(
          context,
          "Niepoprawny adres serwera",
          ToastificationType.error,
        );
      } finally {
        _onStopLoading();
      }
    }
  }

  Future<void> _registerApp() async {
    if (Platform.isAndroid) {
      try {
        await notyficationsService.registerApp();
      } catch (_) {}
    }
  }

  void _goToMainPage() {
    context.go('/documents');
  }

  void _onLoading() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const LoadingDialog(message: Strings.loginLoading);
        });
  }

  void _onStopLoading() {
    Navigator.pop(context);
  }

  bool isValidUrl(String url) {
    final RegExp urlRegExp = RegExp(
      r'^(https?):\/\/'
      r'((([a-zA-Z0-9-]+)\.)+[a-zA-Z]{2,}|(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))'
      r'(:\d{1,5})?'
      r'((\/\S*)?)$',
    );

    return urlRegExp.hasMatch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _controllerServerAddress,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.dns),
                  border: OutlineInputBorder(),
                  labelText: Strings.loginLabelServerAddress,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Pole wymagane";
                  }
                  if (!isValidUrl(value)) {
                    return "Niepoprawny adres HTTPS";
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _controllerUsername,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                  labelText: Strings.loginLabelUsername,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.loginErrorRequired;
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PasswordTextField(
                controller: _controllerPassword,
                authException: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: _login,
              child: Text(
                "Zaloguj się",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controllerServerAddress.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
