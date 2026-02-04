import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modelos/Carta.dart';
import '../utils/logica_tablero.dart';
import '../widgets/tarjeta_memoria.dart';

class TableroJuego extends StatefulWidget {
  const TableroJuego({Key? key}) : super(key: key);

  @override
  State<TableroJuego> createState() => _TableroJuegoState();
}

class _TableroJuegoState extends State<TableroJuego> {
  List<Carta> _cartas = [];
  List<Carta> _cartasVolteadas = [];
  bool _bloquearTablero = false;
  int _intentos = 0;
  int _tiempoTranscurrido = 0;
  Timer? _temporizador;
  int _mejorPuntaje = 0;
  @override
  void initState() {
    super.initState();
    _cargarMejorPuntaje();
    _iniciarJuego();
  }

  @override
  void dispose() {
    _temporizador?.cancel();
    super.dispose();
  }

  Future<void> _cargarMejorPuntaje() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _mejorPuntaje = prefs.getInt('high_score') ?? 0;
    });
  }

  Future<void> _guardarNuevoRecord(int intentos) async {
    final prefs = await SharedPreferences.getInstance();
    if (_mejorPuntaje == 0 || intentos < _mejorPuntaje) {
      await prefs.setInt('high_score', intentos);
      setState(() {
        _mejorPuntaje = intentos;
      });
    }
  }

  void _iniciarJuego() {
    _temporizador?.cancel();
    setState(() {
      _cartas = JuegoUtils.generarTablero();
      _cartasVolteadas.clear();
      _bloquearTablero = false;
      _intentos = 0;
      _tiempoTranscurrido = 0;
    });
    _temporizador = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _tiempoTranscurrido++;
      });
    });
  }

  void _alTocarCarta(int index) {
    if (_bloquearTablero) return;
    if (_cartas[index].estaVolteada || _cartas[index].estaEncontrada) return;
    setState(() {
      _cartas[index].estaVolteada = true;
      _cartasVolteadas.add(_cartas[index]);
    });
    if (_cartasVolteadas.length == 2) {
      _bloquearTablero = true;
      _intentos++;
      _verificarPareja();
    }
  }

  void _verificarPareja() {
    final carta1 = _cartasVolteadas[0];
    final carta2 = _cartasVolteadas[1];
    if (carta1.rutaImagen == carta2.rutaImagen) {
      setState(() {
        carta1.estaEncontrada = true;
        carta2.estaEncontrada = true;
        _cartasVolteadas.clear();
        _bloquearTablero = false;
      });
      _verificarVictoria();
    } else {
      Timer(const Duration(milliseconds: 1000), () {
        setState(() {
          carta1.estaVolteada = false;
          carta2.estaVolteada = false;
          _cartasVolteadas.clear();
          _bloquearTablero = false;
        });
      });
    }
  }

  void _verificarVictoria() {
    bool todasEncontradas = _cartas.every((c) => c.estaEncontrada);
    if (todasEncontradas) {
      _temporizador?.cancel();
      _guardarNuevoRecord(_intentos);
      _mostrarDialogoVictoria();
    }
  }

  void _mostrarDialogoVictoria() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("¡Felicidades!"),
        content: Text(
          "Completaste el juego en $_intentos intentos\nTiempo: $_tiempoTranscurrido seg",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _iniciarJuego();
            },
            child: const Text("Jugar de nuevo"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego de Memoria', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _iniciarJuego,
            tooltip: 'Reiniciar Juego',
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.indigo.shade50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _infoChip("Tiempo", "$_tiempoTranscurrido s", Icons.timer),
                _infoChip("Intentos", "$_intentos", Icons.ads_click),
                _infoChip(
                  "Récord",
                  _mejorPuntaje == 0 ? "--" : "$_mejorPuntaje",
                  Icons.emoji_events,
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int columnas = constraints.maxWidth > 600 ? 6 : 4;
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 350, vertical: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnas,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: _cartas.length,
                  itemBuilder: (context, index) {
                    return TarjetaMemoria(
                      carta: _cartas[index],
                      alTocar: () => _alTocarCarta(index),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String titulo, String valor, IconData icono) {
    return Column(
      children: [
        Icon(icono, color: Colors.indigo, size: 20),
        const SizedBox(height: 4),
        Text(titulo, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          valor,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
