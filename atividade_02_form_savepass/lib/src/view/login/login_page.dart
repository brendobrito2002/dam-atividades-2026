import 'package:flutter/material.dart';
import 'package:save_pass/src/view/login/login_text_field.dart';
import 'package:save_pass/ui/components/app_button.dart';
import 'package:save_pass/ui/font_weights.dart';
import 'package:save_pass/ui/text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Entrar',
                    style: AppTextStyle.headline1.copyWith(
                      fontWeight: AppFontWeight.extraBold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Text(
                'Endereço de e-mail',
                style: AppTextStyle.bodyText1,
              ),
              const SizedBox(height: 12),
              LoginTextField(
                hintText: 'Email',
                obscureText: false,
                icon: Icons.email,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              Text(
                'Sua senha secreta',
                style: AppTextStyle.bodyText1,
              ),
              const SizedBox(height: 12),
              LoginTextField(
                hintText: 'Senha',
                obscureText: true,
                icon: Icons.lock,
                controller: _passwordController,
              ),
              const SizedBox(height: 16),
              AppButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                text: 'Entrar',
              )
            ],
          ),
        ),
      ),
    );
  }
}
