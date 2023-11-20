import 'package:flutter/material.dart';
import 'package:the_vet_app/src/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, Routes.userProfile),
            iconSize: 27.0,
            color: Colors.white,
          )
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
