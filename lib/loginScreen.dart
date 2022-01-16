import 'package:flutter/material.dart';
import 'dart:async';


import 'package:http/http.dart' as http;

import 'main.dart';


Future<String?> attemptLogIn(String email, String password) async {
  var res = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/admin/authenticate'),
      body: {
        "email": email,
        "password": password
      }
  );
  if(res.statusCode == 200) return res.body;
  return null;
}

void displayDialog(context, title, text) => showDialog(
  context: context,
  builder: (context) =>
      AlertDialog(
          title: Text(title),
          content: Text(text)
      ),
);


class LoginScreen extends StatelessWidget  {
  final formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Se connecter"),
      ),
      body: Form(
        key:formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'email :'
                ),
                validator: (value){
                  if (value!.isEmpty){
                    return null;
                  }
                  return 'Please enter an email';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'password :'
                ),
                validator: (value){
                  if (value!.isEmpty){
                    return null;
                  }
                  return 'Please enter a password';
                },
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child:ElevatedButton(
                onPressed: () async {
                  var email=emailController.text;
                  var password=passwordController.text;
                  var jwt = await attemptLogIn(email, password);
                  if(jwt!=null)
                  {
                    storage.write(key:'jwt', value:jwt);
                    print(jwt);
                    Navigator.pop(context);
                  }
                  else {
                    displayDialog(context, "An Error Occurred", "No account was found matching that username and password");
                  }
                },
                child: Text('Se connecter'),
              ),
            )
          ],
        ),

      ),

    );
  }
}
