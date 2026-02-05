import 'package:flutter/material.dart';
import 'tablero_juego.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color.fromARGB(255, 168, 216, 251)!, Colors.white],
          ),
        ),
        child: Column(
  
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            const SizedBox(height: 100),

            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 244, 255), 
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Icon(
                Icons.style_outlined, 
                size: 90,
                color: Colors.indigo[800],
              ),
            ),

            const SizedBox(height: 40), 

            Text(
              '¡Juego de Memoria!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 52,
                height: 1.1, 
                fontWeight: FontWeight.bold, 
                color: Colors.indigo[900],
                letterSpacing: 1.5,
              ),
            ),
            
             const SizedBox(height: 10),
             
             Text(
              '',
               style: TextStyle(
                 fontSize: 20,
                 color: Colors.indigo[400],
                 fontStyle: FontStyle.italic
               ),
             ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 90.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo, 
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40), 
                  ),
                  elevation: 8,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TableroJuego()),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded, size: 30),
                label: const Text('INICIAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}