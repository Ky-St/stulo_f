import 'package:flutter/material.dart';
import 'package:stulo_f/widgets.dart';
import 'main.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: myappbar(), preferredSize: const Size.fromHeight(50)),
        body: const Body_widget(),
    );
  }
}