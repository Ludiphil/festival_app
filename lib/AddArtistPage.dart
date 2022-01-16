import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'main.dart';

class AddArtistPage extends StatefulWidget {
  const AddArtistPage({Key? key}) : super(key: key);

  @override
  _AddArtistPageState createState() => _AddArtistPageState();
}

class _AddArtistPageState extends State<AddArtistPage> {
  final formKey = GlobalKey();
  final nameController = TextEditingController();
  final passtimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajout artiste'),
      ),
      body:Form(
        key:formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'nom de l\'artiste :'
                ),
                validator: (value){
                  if (value!.isEmpty){
                    return null;
                  }
                  return 'Please enter a name';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passtimeController,
                decoration: InputDecoration(
                    labelText: 'heure de passage :'
                ),
                validator: (value){
                  if (value!.isEmpty){
                    return null;
                  }
                  return 'Please enter a passtime';
                },
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child:ElevatedButton(
                onPressed: () async {
                  var name=nameController.text;
                  var passtime=passtimeController.text;
                  var token = storage.read(key:'jwt');
                  var res =http.post(
                      Uri.parse('http://10.0.2.2:8080/api/artist'),
                      body: {
                        'name':name,
                        'passtime':passtime,
                      },
                      headers: {
                        HttpHeaders.authorizationHeader: "Bearer $token",
                      }
                  );
                  Navigator.pop(context);
                },
                child: Text('Ajouter'),
              ),
            )
          ],
        ),

      ),
    );
  }
}


