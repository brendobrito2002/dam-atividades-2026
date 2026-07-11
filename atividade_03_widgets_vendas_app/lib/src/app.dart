import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dependencies.dart';
import 'features/client/client_list_page.dart';
import 'features/client/client_form_page.dart';
import 'features/home/home_page.dart';
import 'features/cart/cart_page.dart';
import 'features/order/order_detail_page.dart';
import 'features/order/order_list_page.dart';
import 'features/product/product_form_page.dart';
import 'features/product/product_list_page.dart';
import 'features/category/category_list_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        title: 'Vendas App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/clients': (context) => const ClientListPage(),
          '/clients/form': (context) => const ClientFormPage(),
          '/products': (context) => const ProductListPage(),
          '/products/form': (context) => const ProductFormPage(),
          '/categories': (context) => const CategoryListPage(),
          '/orders': (context) => const OrderListPage(),
          '/orders/detail': (context) => const OrderDetailPage(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}
