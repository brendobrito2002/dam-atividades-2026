import 'package:flutter/material.dart';
import 'package:save_pass/ui/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  bool _obscurePassword = true;

  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.gray500),
      );
  
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
            color: AppColors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil de Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLabel('Nome de usuário'),
              TextFormField(
                controller: _usernameController,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.black800,
                  hintText: 'Insira seu nome de usuário',
                  hintStyle: const TextStyle(color: AppColors.gray500),
                  border: _border,
                  enabledBorder: _border,
                  focusedBorder: _border.copyWith(
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ), /*
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome de usuário é obrigatório';
                  }
                  if (value.length < 3) {
                    return 'O nome deve ter no mínimo 3 caracteres';
                  }
                  return null;
                },*/
              ),
              const SizedBox(height: 20),
              _buildLabel('E-mail de recuperação'),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.black800,
                  hintText: 'usuario@email.com',
                  hintStyle: const TextStyle(color: AppColors.gray500),
                  border: _border,
                  enabledBorder: _border,
                  focusedBorder: _border.copyWith(
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ), /*
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O e-mail é obrigatório';
                  }
                  if (!_emailRegex.hasMatch(value)) {
                    return 'Informe um e-mail válido';
                  }
                  return null;
                },*/
              ),
              const SizedBox(height: 20),
              _buildLabel('Senha secreta'),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.black800,
                  hintText: 'Sua senha mestra',
                  hintStyle: const TextStyle(color: AppColors.gray500),
                  border: _border,
                  enabledBorder: _border,
                  focusedBorder: _border.copyWith(
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.gray500,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                /*
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A senha é obrigatório';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter no mínimo 6 caracteres';
                  }
                  return null;
                },*/
              ),
            ],
          ),
        ),
      ),
    );
  }
}