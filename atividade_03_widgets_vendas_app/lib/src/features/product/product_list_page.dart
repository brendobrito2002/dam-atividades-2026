import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_bottom_banner.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  void _showSortDialog(BuildContext context, ProductViewModel productViewModel) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Ordenar por:'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                productViewModel.sortByName(ascending: true);
              },
              child: const Text('Nome (A-Z)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                productViewModel.sortByName(ascending: false);
              },
              child: const Text('Nome (Z-A)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                productViewModel.sortByPrice(ascending: true);
              },
              child: const Text('Preço (Menor para Maior)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                productViewModel.sortByPrice(ascending: false);
              },
              child: const Text('Preço (Maior para Menor)'),
            ),
          ],
        );
      },
    );
  }

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
            tooltip: "Filtrar Produtos",
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
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              itemCount: productViewModel.categories.length,
              itemBuilder: (context, index) {
                final category = productViewModel.categories[index];
                final isSelected = productViewModel.currentCategory == category;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) {
                      productViewModel.filterByCategory(category);
                    },
                  ),
                );
              },
            ),
          ),
          // Lista de Produtos
          Expanded(
            child: productViewModel.products.isEmpty
                ? const Center(child: Text('Nenhum produto cadastrado.'))
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: productViewModel.products.length,
                    itemBuilder: (context, index) {
                      final product = productViewModel.products[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: product.imageUrl.isNotEmpty
                                  ? Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        color: Colors.grey[200],
                                        alignment: Alignment.center,
                                        child: const Icon(Icons.broken_image, size: 40),
                                      ),
                                    )
                                  : Container(
                                      color: Colors.grey[200],
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.image, size: 40),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Tooltip(
                                  message: 'Adicionar aos favoritos',
                                  child: IconButton(
                                    icon: Icon(
                                      product.isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: product.isFavorite ? Colors.red : null,
                                    ),
                                    onPressed: () => productViewModel.toggleFavorite(product.id),
                                  ),
                                ),
                                Tooltip(
                                  message: 'Adicionar ao carrinho',
                                  child: IconButton(
                                    icon: const Icon(Icons.add_shopping_cart, color: Colors.blue),
                                    onPressed: () => cartViewModel.addToCart(product),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const CartBottomBanner(),
    );
  }
}
