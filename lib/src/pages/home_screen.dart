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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.pets),
                    title: Text(data['name']),
                    subtitle: Text("Age: ${data['age']}; Weight: ${data['weight']}"),
                    trailing: SizedBox(
                      width: 100, // Adjust this value as needed
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.editPet, arguments: {
                                'name': data['name'],
                                'age': data['age'],
                                'weight': data['weight'],
                                'id': data.id,
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              FirebaseFirestore.instance.collection('animals').doc(data.id).delete();
                            },
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
                      ),
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
