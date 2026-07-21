import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_bottom_banner.dart';

class ClientListPage extends StatelessWidget {
  const ClientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientViewModel = context.watch<ClientViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/clients/form'),
            tooltip: 'Adicionar Cliente',
          ),
        ],
      ),
      body: clientViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : clientViewModel.clients.isEmpty
              ? const Center(child: Text('Nenhum cliente cadastrado.'))
              : ListView.builder(
                  itemCount: clientViewModel.clients.length,
                  itemBuilder: (context, index) {
                    final client = clientViewModel.clients[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(client.name.substring(0, 1).toUpperCase()),
                      ),
                      title: Text(client.name),
                      subtitle: Text('${client.email} | ${client.phone}'),
                    );
                  },
                ),
      bottomNavigationBar: const CartBottomBanner(),
    );
  }
}
