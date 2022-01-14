import 'package:flutter/material.dart';

class ArtistListScreen extends StatelessWidget {
  const ArtistListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Artistes :"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading:Icon(Icons.fastfood),
            title: Text('Burger maison'),
          ),
          ListTile(
            leading:Icon(Icons.fastfood),
            title: Text('pizza maison'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }
}

