import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Root App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Number App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RandomNumberPage(),
    );
  }
}

/// Main Page
class RandomNumberPage extends StatefulWidget {
  const RandomNumberPage({super.key});

  @override
  State<RandomNumberPage> createState() => _RandomNumberPageState();
}

class _RandomNumberPageState extends State<RandomNumberPage> {
  int randomNumber = 0;

  void generateNumber() {
    final random = Random();
    setState(() {
      randomNumber = random.nextInt(100);
    });
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: const Text("Random Number Generator"),
      centerTitle: true,
    );
  }

  Widget buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTitle(),
          const SizedBox(height: 30),
          buildNumberDisplay(),
          const SizedBox(height: 40),
          buildGenerateButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return const Text(
      "Your Random Number",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  Widget buildNumberDisplay() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "$randomNumber",
        style: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget buildGenerateButton() {
    return ElevatedButton(
      onPressed: generateNumber,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: const Text("Generate Number", style: TextStyle(fontSize: 18)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: buildBody());
  }
}
