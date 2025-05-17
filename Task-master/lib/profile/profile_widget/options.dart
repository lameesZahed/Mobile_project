
import 'dart:io';

import 'package:flutter/material.dart';

class Options extends StatelessWidget { //widget 3ama lel 3 w ab3t el title w el icon ely 3yzah lel 3
  final String title;
  final IconData icon;
  Colors? color;
  File ? selectedImage;
  VoidCallback onPressed;
  Options({ required this.onPressed,this.color, this.selectedImage ,required this.title,required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      IconButton(
          color: selectedImage == null ? Colors.grey.shade800 : Colors.red, //null ub2a grey lw msh null yb2a red
          icon: Icon(icon), onPressed: onPressed),
      Text(title , style: TextStyle(color: selectedImage == null? Colors.grey.shade800 : Colors.red),)
      // return => ;
    ],);
  }
}