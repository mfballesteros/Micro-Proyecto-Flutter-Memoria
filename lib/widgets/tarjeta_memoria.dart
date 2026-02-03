import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:micro_proyecto/modelos/Carta.dart';

class TarjetaMemoria extends StatelessWidget {
  final Carta carta;
  final VoidCallback alTocar;

  const TarjetaMemoria({Key? key, required this.carta, required this.alTocar})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool mostrarContenido = carta.estaVolteada || carta.estaEncontrada;
    return GestureDetector(
      onTap: () {
        if (!mostrarContenido) {
          alTocar();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: mostrarContenido ? Colors.white : Colors.indigoAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
          border: carta.estaEncontrada
              ? Border.all(color: Colors.amber, width: 3)
              : null,
        ),
        child: mostrarContenido ? _construirCaraFrontal() : _construirDorso(),
      ),
    );
  }

  Widget _construirCaraFrontal() {
    return FlipInY(
      duration: const Duration(milliseconds: 400),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            carta.rutaImagen,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _construirDorso() {
    return const Center(
      child: Icon(Icons.question_mark, color: Colors.white54, size: 30),
    );
  }
}
