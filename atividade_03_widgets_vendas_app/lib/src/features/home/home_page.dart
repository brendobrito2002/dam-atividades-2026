import 'package:flutter/material.dart';
import 'package:vendas_app/src/features/home/widgets/drawer.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_bottom_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Vendas App'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  _MenuListTile(
                    icon: Icons.people,
                    label: 'Clientes',
                    color: Colors.green,
                    onTap: () => Navigator.pushNamed(context, '/clients'),
                  ),
                  _MenuListTile(
                    icon: Icons.inventory_2,
                    label: 'Produtos',
                    color: Colors.orange,
                    onTap: () => Navigator.pushNamed(context, '/products'),
                  ),
                  _MenuListTile(
                    icon: Icons.category,
                    label: 'Categorias',
                    color: Colors.purple,
                    onTap: () => Navigator.pushNamed(context, '/categories'),
                  ),
                  _MenuListTile(
                    icon: Icons.shopping_cart,
                    label: 'Pedidos',
                    color: Colors.blue,
                    onTap: () => Navigator.pushNamed(context, '/orders'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CartBottomBanner(),
    );
  }
}

class _MenuListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MenuListTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
