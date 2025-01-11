import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/games/problem_solving/maze/maze.dart';

Future<void> itemSelected(BuildContext context, int index) async {
  Navigator.of(context).pop();
  switch(index) {
    case 0: Navigator.push(context, MaterialPageRoute(builder: (context)=> const MazeDashBoard()));
  }
}