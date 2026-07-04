import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // CONFIGURACAO
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFF5722)
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 200
          )
        )
      ),

      // ESTRUTURA
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pedido Flash")
        ),
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
