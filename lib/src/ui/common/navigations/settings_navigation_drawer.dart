import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/ui/common/dividers/details_divider.dart';
import 'package:attado_mobile/src/ui/common/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsNavigationDrawer extends StatefulWidget {
  const SettingsNavigationDrawer({
    super.key,
    required this.authRepo,
  });

  final AuthRepo authRepo;

  @override
  State<SettingsNavigationDrawer> createState() =>
      _SettingsNavigationDrawerState();
}

class _SettingsNavigationDrawerState extends State<SettingsNavigationDrawer> {
  bool _isBiometric = false;
  bool _isDarkMode = false;
  late AppProvider _appProvider;

  @override
  void initState() {
    super.initState();
    widget.authRepo.getBiometricAuthFromSecureStorage().then((value) {
      setState(() {
        if (value == true) {
          _isBiometric = true;
        } else {
          _isBiometric = false;
        }
      });
    });
    setState(() {
      _isDarkMode = Provider.of<AppProvider>(context, listen: false).darkTheme;
    });
  }

  Future<void> _setBiometric(bool value) async {
    setState(() {
      _isBiometric = value;
    });
    await widget.authRepo.saveBiometricAuthToSecureStorage(value);
    Fluttertoast.showToast(
      msg: value
          ? "Logowanie biometryczne włączone"
          : "Logowanie biometryczne wyłączone",
    );
  }

  Future<void> _setDarkMode(bool value) async {
    setState(() {
      _isDarkMode = value;
    });
    await _appProvider.setDarkTheme(value);
  }

  Future<void> _logout() async {
    await widget.authRepo.logout();
    // ignore: use_build_context_synchronously
    context.go("/login");
    Fluttertoast.showToast(
      msg: "Wylogowano",
    );
  }

  Future<void> _goToSettings() async {
    if (Platform.isAndroid) {
      AndroidIntent intent = const AndroidIntent(
        action: 'action_application_details_settings',
        data: 'package:com.appincode.attado_mobile',
      );
      await intent.launch();
    }
  }

  @override
  Widget build(BuildContext context) {
    _appProvider = Provider.of(context);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 35, left: 20, bottom: 15),
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: 40,
            ),
          ),
          const DetailsDivider(),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 7.5),
            child: Text(
              "Konto",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Row(
              children: [
                const Icon(Icons.person_outline),
                const SizedBox(width: 10),
                Text(
                  widget.authRepo.authUser!.username,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 15),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Row(
              children: [
                const Icon(Icons.dns_outlined),
                const SizedBox(width: 10),
                Text(
                  widget.authRepo.serverUrl!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 15),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 10),
            child: TextButton(
              onPressed: _logout,
              child: const Text("WYLOGUJ"),
            ),
          ),
          const DetailsDivider(),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 7.5),
            child: Text(
              "Ustawienia",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 2.5, right: 2.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.fingerprint),
                    const SizedBox(width: 10),
                    Text(
                      "Logowanie biometryką",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 15),
                    ),
                  ],
                ),
                Switch(
                  value: _isBiometric,
                  onChanged: _setBiometric,
                ),
              ],
            ),
          ),
          Platform.isAndroid
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 15, top: 2.5, right: 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.notifications_outlined),
                          const SizedBox(width: 10),
                          Text(
                            "Powiadomienia",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: IconButton(
                            onPressed: _goToSettings,
                            icon: const Icon(Icons.settings)),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 2.5, right: 2.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.dark_mode_outlined),
                    const SizedBox(width: 10),
                    Text(
                      "Tryb ciemny",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 15),
                    ),
                  ],
                ),
                Switch(
                  value: _isDarkMode,
                  onChanged: _setDarkMode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
