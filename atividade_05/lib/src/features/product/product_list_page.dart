import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_bottom_banner.dart';
import 'package:vendas_app/src/features/product/widgets/product_card.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();
    final cartViewModel = context.read<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortDialog(context, productViewModel),
            tooltip: 'Ordenar Produtos',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/products/form'),
            tooltip: 'Adicionar Produto',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros de Categoria (Chips horizontais)

          // Lista de Produtos
          Expanded(
            child: productViewModel.products.isEmpty
                ? const Center(child: Text('Nenhum produto cadastrado.'))
                : GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: productViewModel.products.length,
                    itemBuilder: (context, index) {
                      final product = productViewModel.products[index];
                      return ProductCard(
                        product: product,
                        productViewModel: productViewModel,
                        cartViewModel: cartViewModel,
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const CartBottomBanner(),
    );
  }

  void _showSortDialog(BuildContext context, ProductViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Ordenar por:'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByName(ascending: true);
                Navigator.pop(context);
              },
              child: const Text('Nome (A-Z)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByName(ascending: false);
                Navigator.pop(context);
              },
              child: const Text('Nome (Z-A)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByPrice(ascending: true);
                Navigator.pop(context);
              },
              child: const Text('Preço (Menor para Maior)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByPrice(ascending: false);
                Navigator.pop(context);
              },
              child: const Text('Preço (Maior para Menor)'),
            ),
          ],
        );
      },
    );
  }
}
