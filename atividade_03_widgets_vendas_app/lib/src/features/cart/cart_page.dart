import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';
import 'package:vendas_app/src/features/order/order_viewmodel.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();
    final clientViewModel = context.watch<ClientViewModel>();
    final orderViewModel = context.read<OrderViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: cartViewModel.items.isEmpty
          ? const Center(child: Text('Seu carrinho está vazio.'))
          : Column(
              children: [
                // Seleção de Cliente
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButtonFormField<ClientModel>(
                    decoration: const InputDecoration(
                      labelText: 'Selecione o Cliente *',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: cartViewModel.selectedClient,
                    hint: const Text('Selecione um cliente'),
                    items: clientViewModel.clients.map((client) {
                      return DropdownMenuItem<ClientModel>(
                        value: client,
                        child: Text(client.name),
                      );
                    }).toList(),
                    onChanged: (client) {
                      if (client != null) {
                        cartViewModel.selectClient(client);
                      }
                    },
                  ),
                ),
                // Lista de Itens do Carrinho
                Expanded(
                  child: ListView.builder(
                    itemCount: cartViewModel.items.length,
                    itemBuilder: (context, index) {
                      final item = cartViewModel.items[index];
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text(
                          'Unitário: R\$ ${item.product.price.toStringAsFixed(2)} | Total: R\$ ${item.total.toStringAsFixed(2)}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                cartViewModel.updateQuantity(
                                  item.product.id,
                                  item.quantity - 1,
                                );
                              },
                            ),
                            Text(
                              item.quantity.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                cartViewModel.updateQuantity(
                                  item.product.id,
                                  item.quantity + 1,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Resumo Financeiro e Checkout
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Valor Total:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'R\$ ${cartViewModel.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () async {
                          try {
                            final orderResult = await cartViewModel.checkout();
                            // Atualiza o histórico de pedidos
                            await orderViewModel.loadOrders();

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Pedido realizado com sucesso!'),
                                ),
                              );
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('/orders/detail', arguments: orderResult);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'FINALIZAR PEDIDO',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
