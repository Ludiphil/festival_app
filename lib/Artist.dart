import 'package:flutter/material.dart';

class Artist {
  int passtime;
  String name;

  Artist(this.passtime, this.name);



  int get art_passtime{
    return passtime;
  }
  String get art_name{
    return name;
  }

  @override
  String toString() {
    return 'Artist{passtime: $passtime, name: $name}';
  }
}