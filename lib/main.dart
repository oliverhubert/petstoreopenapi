// @dart=2.9

import 'package:flutter/material.dart';
import 'petstore_api/lib/api.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          //      title: Text(widget.title),
          ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                icon: Icon(Icons.flutter_dash),
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            /*  FutureBuilder<Pet>(
                future: PetApi().getPetById(666999),
                builder: (BuildContext context, AsyncSnapshot<Pet> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('Pet not found...'));
                  }
                  return Center(child: Text('Result: ${snapshot.data}'));
                }), */
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                await PetApi().addPet(
                  Pet(
                    id: 550055,
                    name: nameController.text,
                    status: PetStatusEnum.available,
                  ),
                );

                setState(
                  () {
                    nameController.clear();
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.book_online),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PetstoreList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PetstoreList extends StatefulWidget {
  @override
  _PetstoreListState createState() => _PetstoreListState();
}

class _PetstoreListState extends State<PetstoreList> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<Pet>(
            future: PetApi().getPetById(550055),
            builder: (BuildContext context, AsyncSnapshot<Pet> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Pet not found...'));
              }
              return Center(child: Text('Result: ${snapshot.data}'));
            }));
  }
}

void _addNewPet() {
  final _petApi = PetApi();
  final _pet = Pet(id: 550055, name: "testtierXXX");
  PetApi().addPet(_pet);
  print(_pet);
}

Pet _findPet() {
  FutureBuilder<Pet>(
      future: PetApi().getPetById(333),
      builder: (BuildContext context, AsyncSnapshot<Pet> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text('Pet not found...'));
        }
        return Center(child: Text('Result: ${snapshot.data}'));
      });
}

List _findPetStatus() {
  final api_instance = PetApi();
  final status =
      []; // List<String> | Status values that need to be considered for filter

  try {
    final result = api_instance.findPetsByStatus(status);
    print(result);
  } catch (e) {
    print('Exception when calling PetApi->findPetsByStatus: $e\n');
  }
}
