import 'package:flutter/material.dart';
import 'package:flutternotekeeperapp/screen/note_list.dart';

void main() => runApp(

  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'demo',
    theme: ThemeData(
      primaryColor: Colors.yellow,
      accentColor: Colors.yellowAccent),
  home: NoteList(),)

);