import 'package:flutter/material.dart';
import 'package:musically/presentation/screeens/drawer_homescreen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("P L A Y L I S T"),
      ),drawer: DrawerHomescreen(),
    );
  }
}