import 'package:appli_festival/AddArtistPage.dart';
import 'package:appli_festival/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:appli_festival/main.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'loginScreen.dart';
import 'SettingsPage.dart';


import 'package:http/http.dart' as http;

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    //get the arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch(settings.name)
    {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/login':
          return MaterialPageRoute(
              builder: (_) => LoginScreen(
              ),
          );
      case '/settings':
          return MaterialPageRoute(
              builder: (_) => SettingsPage(
              ),
          );
      case '/addArtist':
          return MaterialPageRoute(
              builder: (_) => AddArtistPage(
              ),
          );
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Text(('Error')),
        ),
      );
    });
  }
}

