import 'package:flutter/material.dart';
import 'package:save_pass/src/controller/sqlite_password_controller.dart';
import 'package:save_pass/src/model/password_model.dart';
import 'package:save_pass/ui/colors.dart';
import 'package:save_pass/ui/components/app_button.dart';
import 'package:save_pass/ui/components/custom_text_field.dart';
import 'package:save_pass/ui/text_styles.dart';
import 'package:provider/provider.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key, this.passwordModel});

  final PasswordModel? passwordModel;

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  bool isEdit = false;

  @override
  void initState() {
    isEdit = widget.passwordModel != null;
    if (isEdit) {
      _nameController.text = widget.passwordModel?.serviceName ?? '';
      _usernameController.text = widget.passwordModel?.username ?? '';
      _passwordController.text = widget.passwordModel?.password ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Cadastro de Senha'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                'Nome do serviço',
                style: AppTextStyle.bodyText1,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                hintText: 'Nome do serviço',
                controller: _nameController,
              ),
              const SizedBox(height: 12),
              Text(
                'Email ou usuário',
                style: AppTextStyle.bodyText1,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                hintText: 'Email ou usuário',
                controller: _usernameController,
              ),
              const SizedBox(height: 12),
              Text(
                'Senha',
                style: AppTextStyle.bodyText1,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                hintText: 'Senha',
                obscureText: _isObscure,
                controller: _passwordController,
                suffix: GestureDetector(
                  child: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.gray200,
                  ),
                  onTap: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              AppButton(
                onPressed: () async {
                  String serviceName = _nameController.text;
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  if (serviceName.isEmpty ||
                      username.isEmpty ||
                      password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha todos os campos'),
                      ),
                    );
                  } else {
                    final newPassword = PasswordModel(
                      serviceName: serviceName,
                      username: username,
                      password: password,
                    );
                    if (isEdit) {
                      await context
                          .read<SQlitePasswordController>()
                          .updatePassword(newPassword);
                    } else {
                      await context
                          .read<SQlitePasswordController>()
                          .addPassword(newPassword);
                    }
                    if (!mounted) return;
                    Navigator.pop(context, isEdit ? newPassword : null);
                  }
                },
                text: isEdit ? 'Editar' : 'Salvar',
              )
            ],
          ),
        ),
      ),
    );
  }
}
