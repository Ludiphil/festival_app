import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Artist.dart';
import 'main.dart';



Future<List<Artist>> fetchArtist() async {

  final response = await http
      .get(Uri.parse('http://10.0.2.2:8080/api/artist'));


  if (response.statusCode == 200) {
    List<Artist> artists=[];
    print(response.body);
    final jsonData=json.decode(response.body);
    var obj;
    for(obj in jsonData){
      // print(obj['name']);
      // print(obj['pass_time']);
      Artist artist = new Artist(obj['pass_time'], obj['name']);
      print(artist);
      artists.add(artist);
    }

    return artists;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load all of artists');
  }
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Artist>> futureArtist;
  late List<Artist> artists = [];

  //shared preferences
  //s'arreter au onpressed
  //column, row

  void getArtist() async{
    artists= await futureArtist;
  }

  @override
  void initState() {
    super.initState();
    futureArtist = fetchArtist();
    getArtist();
    print(storage.read(key: 'jwt'));
  }


  @override
  build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Hellfest'),
          ),
          actions: [
            storage.read(key:'jwt')==null ?
            IconButton(
                icon: Icon(
                    Icons.login,
                    color: const Color(0xFF000000),
                    size: 34.0),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      '/login');
                }
            ):
            IconButton(
                icon: Icon(
                    Icons.add,
                    color: const Color(0xFFFFFFFF),
                    size: 34.0),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      '/addArtist');
                }
            ),
            IconButton(
              icon: Icon(
              Icons.disabled_by_default_sharp,
              color: const Color(0xFF000000),
              size: 34.0),
              onPressed: () {
                storage.deleteAll();
                Navigator.of(context).pushNamed(
                  '/');
                }
            ),
          ],
        ),
        body:
        SingleChildScrollView(
          child:Column(
            children: [
              Image.network('https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.lagrosseradio.com%2F_images%2Ffck%2F13018.jpg&f=1&nofb=1'),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: artists.length,
                itemBuilder: (context,index){
                  return Card(
                      child: ListTile(
                        leading: storage.read(key:'jwt')!=null ?
                        IconButton(
                              icon: Icon(
                                  Icons.settings,
                                  color: const Color(0xFF000000),
                                  size: 34.0),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    '/settings' /*,arguments: 'Hello world from the first page'*/);
                              }
                          ) : Icon(Icons.ac_unit),
                        title: Text('${artists[index].name}',style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text('${artists[index].passtime~/100}h${artists[index].passtime%100}',textAlign: TextAlign.right,),
                        trailing: IconButton(
                            icon: Icon(
                                Icons.delete,
                                color: const Color(0xFF000000),
                                size: 34.0),
                            onPressed: () {
                              http.delete(Uri.parse('http://10.0.2.2:8080/api/artist${artists[index].name}'));
                              Navigator.pop(context);
                            }
                        ),
                      )
                  );
                },
              )
            ],
          ),
          ),



    );
  }
}
