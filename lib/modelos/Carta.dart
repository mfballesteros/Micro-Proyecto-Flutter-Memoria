class Carta {
  final int id;
  final String rutaImagen;
  bool estaVolteada;
  bool estaEncontrada;

  Carta({
    required this.id,
    required this.rutaImagen,
    this.estaVolteada = false,
    this.estaEncontrada = false,
  });
}
