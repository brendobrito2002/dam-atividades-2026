import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/settings/settings_viewmodel.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsViewModel = context.watch<SettingsViewModel>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Vendas App',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Clientes'),
            onTap: () {
              Navigator.pushNamed(context, '/clients');
            },
          ),
          ListTile(
            title: Text('Produtos'),
            onTap: () {
              Navigator.pushNamed(context, '/products');
            },
          ),
          ListTile(
            title: Text('Categorias'),
            onTap: () {
              Navigator.pushNamed(context, '/categories');
            },
          ),
          ListTile(
            title: Text('Pedidos'),
            onTap: () {
              Navigator.pushNamed(context, '/orders');
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Modo Escuro'),
            value: settingsViewModel.isDarkMode,
            onChanged: (_) {
              settingsViewModel.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}