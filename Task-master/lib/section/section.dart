import 'package:flutter/material.dart';

class newScreen extends StatelessWidget {
  newScreen({super.key});
  List<int>  selectednumber = [1,2,3,4,5];
  List<String> names =["sam",'fatma','hana','lamees'];
  @override
  Widget build(BuildContext context) {
    return  Scaffold( appBar: AppBar(title: Text("Profile"),),

        body: Column(children: [

          ListView(children:
          selectednumber.map((toElement)=>      Container(
            alignment: Alignment.center,
            child:
            CircleAvatar(
                backgroundColor:  Colors.red,
                radius: 50 ,child:  Text("$toElement")

            )
            ,)).toList()
          ),
          ListView(
              scrollDirection:  Axis.horizontal,


              children:
              names.map((toElement)=>      Container(
                alignment: Alignment.center,
                child:
                CircleAvatar(
                    backgroundColor:  Colors.red,
                    radius: 50 ,child:  Text("$toElement")




                )
                ,)).toList()
          )
        ],)



    );

  }
}