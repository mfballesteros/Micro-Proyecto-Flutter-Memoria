import 'package:flutter/material.dart';
import 'pantallas/tablero_juego.dart';
import 'pantallas/inicio.dart';

void main() {
  runApp(const juegoMemoria());
}

class juegoMemoria extends StatelessWidget {
  const juegoMemoria({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Juego de Memoria Flutter',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const InicioScreen(),
    );
  }
}
