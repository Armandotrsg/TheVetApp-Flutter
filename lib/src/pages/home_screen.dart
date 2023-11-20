import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_vet_app/src/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My animals', style: TextStyle(color: Colors.white)),
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('animals').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.docs.isEmpty ?? true) {
            return const Center(child: Text('No animals found'));
          } else {
            return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.pets),
                  title: Text(data['name']),
                  subtitle: Text("Age: ${data['age']}; Weight: ${data['weight']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      FirebaseFirestore.instance.collection('animals').doc(data.id).delete();
                    },
                  ),
                ),
              );
            },
          );
          }
          
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.addPet),
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
