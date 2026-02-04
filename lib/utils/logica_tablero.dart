import 'package:micro_proyecto/modelos/Carta.dart';

class JuegoUtils {
  static const int cantidadPares = 18;
  static final List<String> listaDeImagenes = [
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/img6.png',
    'assets/img7.png',
    'assets/img8.png',
    'assets/img9.png',
    'assets/img10.png',
    'assets/img11.png',
    'assets/img12.png',
    'assets/img13.png',
    'assets/img14.png',
    'assets/img15.png',
    'assets/img16.png',
    'assets/img17.png',
    'assets/img18.png',
  ];
  static List<Carta> generarTablero() {
    List<Carta> cartas = [];
    for (int i = 0; i < cantidadPares; i++) {
      String imagen = listaDeImagenes[i % listaDeImagenes.length];
      Carta cartaA = Carta(id: 0, rutaImagen: imagen);
      Carta cartaB = Carta(id: 0, rutaImagen: imagen);
      cartas.add(cartaA);
      cartas.add(cartaB);
    }
    cartas.shuffle();
    for (int i = 0; i < cartas.length; i++) {
      cartas[i] = Carta(
        id: i,
        rutaImagen: cartas[i].rutaImagen,
        estaVolteada: false,
        estaEncontrada: false,
      );
    }
    return cartas;
  }
}
