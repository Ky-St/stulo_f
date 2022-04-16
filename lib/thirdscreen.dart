import 'package:flutter/material.dart';
import 'package:stulo_f/widgets.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("MainActivity3");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
            child: myappbar(), preferredSize: const Size.fromHeight(50)),
        body: const Liste_widget(),
      ),
    );
  }
}