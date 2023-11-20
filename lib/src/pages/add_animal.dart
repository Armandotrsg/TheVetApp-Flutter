import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPetScreen extends StatefulWidget {
  final String? name;
  final String? age;
  final String? weight;
  final String? id;
  const AddPetScreen({super.key, this.name, this.age, this.weight, this.id});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  late String appBarTitle;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    appBarTitle = widget.name != null ? 'Edit animal' : 'Add animal';
    nameController.text = widget.name ?? '';
    ageController.text = widget.age ?? '';
    weightController.text = widget.weight ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
              ),
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: 'Weight',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (widget.id != null) {
                  FirebaseFirestore.instance
                      .collection('animals')
                      .doc(widget.id)
                      .update({
                    'name': nameController.text,
                    'age': ageController.text,
                    'weight': weightController.text,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Animal updated'),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.pop(context);
                } else if (nameController.text.isNotEmpty &&
                    ageController.text.isNotEmpty &&
                    weightController.text.isNotEmpty) {
                  FirebaseFirestore.instance.collection('animals').add({
                    'name': nameController.text,
                    'age': ageController.text,
                    'weight': weightController.text,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Animal added'),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please fill all the fields'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Text(widget.name != null ? 'Edit' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
