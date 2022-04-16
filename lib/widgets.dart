import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:ui';
import 'events.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Widget für die Darstellung von AppBar
Widget myappbar() {
  return AppBar(
    backgroundColor: mainColorPurple,
    title: const Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        "STULO",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

// ignore: camel_case_types
class Body_widget extends StatefulWidget {
  const Body_widget({Key? key}) : super(key: key);
  @override
  _Body_widgetState createState() => _Body_widgetState();
}

// ignore: camel_case_types
class _Body_widgetState extends State<Body_widget> {
  // ignore: non_constant_identifier_names
  final employer_inputcontroller = TextEditingController();
  // ignore: non_constant_identifier_names
  final hours_inputcontroller = TextEditingController();
  // ignore: non_constant_identifier_names
  final salary_inputcontroller = TextEditingController();
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  //Funktion für den Speicher von Events(local) mit Shared Preferences
  save() async{
    SharedPreferences sharedPreferences_ = await SharedPreferences.getInstance();
    //Event wird als Json gespeichert
    String jsonEvent = jsonEncode(events);
    // ignore: avoid_print
    print("Die Daten sind gespeichert: " + jsonEvent);
    sharedPreferences_.setString("event_string", jsonEvent);
  }
  //Funktion für das Herunterladen von Events
  load() async{
    SharedPreferences sharedPreferences_ = await SharedPreferences.getInstance();
    String? jsonEvent = sharedPreferences_.getString("event_string");
    if (jsonEvent != null) {
      // ignore: avoid_print
      print("Die Daten sind heruntergeladen: " + jsonEvent);
      var map_ = jsonDecode(jsonEvent);
      // ignore: avoid_print
      print("Map:  + $map_");
      //Umwandlung von String in List von Events
      List<Event> events_ = map_.map<Event>((m) => Event.fromJson(Map<String, String>.from(m))).toList();
      // ignore: avoid_print
      print(events_);
      setState(() {
        events = events_;
      });
    }
    }
  //Funktion für die Erstellung von Event mit der Berechnung des Gewinns
  calculate(BuildContext context) {
    String employer = employer_inputcontroller.text;
    String salary = salary_inputcontroller.text;
    String hours = hours_inputcontroller.text;
    //Bedingung für die Überprüfung von Anwesenheit der Events
    if (employer != "" && hours != "" && salary != "" && _selectedDay != null) {
      final numberHoursDouble = double.parse(hours);
      double salaryHoursDouble = double.parse(salary);
      double resultDouble = numberHoursDouble * salaryHoursDouble;
      String result = resultDouble.toString();
      if (_selectedDay != null) {
        String calendarFormat = _selectedDay!.day.toString() + "/" +
            _selectedDay!.month.toString() + "/" +
            _selectedDay!.year.toString();
        var events_ = Event(employer = employer, salary = salary,
            hours = hours, result = result, calendarFormat);
        // ignore: avoid_print
        print(events_);
        //Hinzufügen von Event in ArrayList
        events.add(events_);
        // ignore: avoid_print
        print(events.length);
      }
      return Navigator.pushNamed(context, "/third");
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Keine Daten!", style: TextStyle(color: Colors.red)),
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0))),
      ));
      // ignore: avoid_print
      print("Keine Eingabe");
    }
  }
  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    save();
    load();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Ein Box, wo man die Widgets scrollen kann
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: mainColorPurple, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            //Widget zum Scrollen
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColorPurple, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextField(
                        //Texteingabe
                        cursorColor: Colors.black,
                        controller: employer_inputcontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.account_balance,
                              color: Colors.black,
                            ),
                            labelText: "Arbeitgeber",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    //Textfield befindet sich im Container
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColorPurple, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: hours_inputcontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.access_time, color: Colors.black),
                            labelText: "Arbeitsstunden",
                            labelStyle: TextStyle(color: Colors.black)),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColorPurple, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: salary_inputcontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.monetization_on,
                              color: Colors.black,
                            ),
                            labelText: "Stundenlohn",
                            labelStyle: TextStyle(color: Colors.black)),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColorPurple, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TableCalendar(
                        focusedDay: _focusedDay,
                        firstDay: DateTime.utc(2022, 01, 01),
                        lastDay: DateTime.utc(2030, 01, 01),
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay; // update `_focusedDay` here as well
                          });
                          // ignore: avoid_print
                          print("$_selectedDay");
                        },
                        calendarFormat: _calendarFormat,
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                      ),
                    ),
                  ),
                  //Widget zum horizontalen Anzeigen von Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(mainColorPurple),
                                padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                            ),
                              onPressed: () {
                                calculate(context);
                              },
                              child: const Text(
                                "Erstellen",
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(mainColorPurple),
                                  padding: MaterialStateProperty.all(const EdgeInsets.all(10))
                              ),
                              onPressed: () {
                                if (events.isNotEmpty) {
                                  Navigator.pushNamed(context, '/third');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Keine Events!", style: TextStyle(color: Colors.red)),
                                    behavior: SnackBarBehavior.fixed,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0))),
                                  ));
                                }
                              },
                              child: const Text(
                                "Events",
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
// ignore: camel_case_types
class Liste_widget extends StatefulWidget {
  const Liste_widget({Key? key}) : super(key: key);

  @override
  _Liste_widgetState createState() => _Liste_widgetState();
}

// ignore: camel_case_types
class _Liste_widgetState extends State<Liste_widget> {
  @override
  Widget build(BuildContext context) {
    //Erstellung von Listview
    return ListView.builder(
        itemCount: events.length,
        padding: const EdgeInsets.all(5.0),
        itemBuilder: (_, index) => Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            //Löschen von Event mit der Bewegung von Links nach Rechts
            if(direction == DismissDirection.startToEnd){
              events.removeAt(index);
              // ignore: avoid_print
              print(events.length);
            } else {
              //Löschen von Event
              events.removeAt(index);
            }
          },
          //Listview mit Cards
          background: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(right: 20.0),
            decoration: BoxDecoration(
              border: Border.all(color: mainColorPurple, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: const Icon(Icons.delete, color: Colors.black),
          ),
          //Widget für die Größe des Kartes
          child: SizedBox(
            height: 150,
            width: 400,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: mainColorPurple, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Arbeitgeber: " + events[index].employer + "\nArbeitsstunden: " + events[index].hours + "\nStundenlohn: " + events[index].salary + "\nGewinn: "
                      + events[index].result + "\nDatum: " + events[index].calendar,
                  style: const TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ),
        ));
  }
}

