// ignore_for_file: library_private_types_in_public_api, prefer_final_locals, use_named_constants

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _numbController = TextEditingController();
  static Random ran = Random();
  int randomnr = ran.nextInt(100) + 1;
  String mesaj = '';

  void guess() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    int guess = int.parse(_numbController.text);

    if (guess > 100 || guess < 1) {
      mesaj = 'Numarul trebuie sa fie >=1 si <=100';
      _numbController.clear();
      return;
    }

    if (guess > randomnr) {
      mesaj = 'Try Lower !';
    } else if (guess < randomnr) {
      mesaj = 'Try Hight !';
    } else if (guess == randomnr) {
      mesaj = 'Very good , the number is :  $randomnr';
      randomnr = ran.nextInt(100) + 1;
    }
    _numbController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Guess Number'),
          ),
        ),
        body: Form(
          child: Center(
            child: Column(
              children: <Widget>[
                const Text(
                  'Enter a number between 1 and 100 ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.blueAccent,
                  ),
                ),
                const Text(
                  'Try to fiind',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.black,
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Try a number',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        textAlign: TextAlign.center,
                        controller: _numbController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          guess();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Result :  '),
                              content: Text(mesaj),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Try Again'))
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          'Guess',
                          style: TextStyle(
                            fontSize: 15.22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
