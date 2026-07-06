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
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFFFF5722)),
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 20)),
      ),

      // ESTRUTURA
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Pedido Flash",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF5722), Color(0xFFFF8C00)],
                  ),
                ),
                width: 350,
                height: 120,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Menu Caixa",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/car.png",
                            width: 30,
                            height: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Novo Pedido",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/historical.png",
                            width: 30,
                            height: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Histórico",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/setting.png",
                            width: 30,
                            height: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Configurações",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Cardápio Rápido!", style: TextStyle(fontWeight: FontWeight.bold))
                )
              ),
              Card(
                elevation: 2,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/pizza.png",
                        width: 30,
                        height: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Pizza Calabresa",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("R\$ 45,00", style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/cerveja.png",
                        width: 30,
                        height: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Chopp Artesanal",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("R\$ 12,00", style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/hamburguer.png",
                        width: 30,
                        height: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Hámburguer Duplo",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("R\$ 32,00", style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
