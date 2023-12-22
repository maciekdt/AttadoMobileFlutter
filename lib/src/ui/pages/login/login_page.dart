import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/ui/pages/login/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required this.authRepo,
  });
  final AuthRepo authRepo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
              ),
              LoginForm(repo: authRepo),
            ],
          ),
        ),
      ),
    );
  }
}
