import 'package:flutter/material.dart';
import 'package:stulo_f/secondscreen.dart';
import 'package:stulo_f/widgets.dart';
import 'widgets.dart';
import 'thirdscreen.dart';

var mainColorPurple = const Color.fromARGB(255, 110, 38, 88);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("MainActivity1");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Es verwendet Materialdesignsprache und konfiguriert Navigator für die Suche von Routes
      title: "Navigation",
      home: const FirstScreen(),
      routes: {
        '/first': (context) => const FirstScreen(),
        '/second': (context) => const SecondScreen(),
        '/third': (context) => const ThirdScreen(),
      },
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //Liefert Struktur und Design einer Material-App
        appBar: PreferredSize(
            // Es wird verwendet, um die Höhe von Appbar festzustellen
            preferredSize: const Size.fromHeight(50.0),
            child: myappbar()),
        body: Center(
          //Zentriert das Kind in sich selbst
          child: Container(
            //Dient zur Positionierung, Veränderung der Größe und zum Zeichnen
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: mainColorPurple, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            ),
            child: Padding(
              //Container wird mit Padding umgeschlossen
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                //Abriss von Child in Form von abgerundetem Rechteck
                borderRadius: BorderRadius.circular(30),
                child: GestureDetector(
                  //Erkennung von Gesten
                  onTap: () {
                    Stopwatch stop = Stopwatch();
                    stop.start();
                    Navigator.pushNamed(
                        context, '/second');
                    stop.stop();//ruft die Route auf
                    print("MainActivity2: +${stop.elapsedMicroseconds}ms");
                  },
                  child: Image.asset(
                      'assets/images/logo.png'), // Herunterladen von Image
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
