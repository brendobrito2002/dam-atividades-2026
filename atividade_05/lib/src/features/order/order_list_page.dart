import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/order/order_viewmodel.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_bottom_banner.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderViewModel = context.watch<OrderViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos Realizados'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: orderViewModel.orders.isEmpty
          ? const Center(child: Text('Nenhum pedido realizado.'))
          : ListView.builder(
              itemCount: orderViewModel.orders.length,
              itemBuilder: (context, index) {
                final order = orderViewModel.orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('Pedido #${order.id.substring(0, 8)}'),
                    subtitle: Text(
                      'Cliente: ${order.client.name}\nData: ${order.date.day}/${order.date.month}/${order.date.year}',
                    ),
                    trailing: Text(
                      'R\$ ${order.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/orders/detail',
                        arguments: order,
                      );
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: const CartBottomBanner(),
    );
  }
}
