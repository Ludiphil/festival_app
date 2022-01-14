import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                onPressed: (){
                    Navigator.pop(context);
                  
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
