import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:task/add_item/add_item_screen.dart';
import 'package:task/add_item/item_model.dart';


import 'package:task/profile/profile_page/profile_page.dart';
import 'package:task/profile/user_model.dart';

import '../details_widget/details_widget.dart';

class DetailsPage extends StatelessWidget {

    //final String ? title; // mmkn y2blo null
    //final String ? body;
    //final List<File> ? image; //hst2bl wl list
   // const DetailsPage({this.image, this.body,  this.title,super.key});

  @override
  Widget build(BuildContext context )  {
   final profileImage =  Provider.of<UserModel>(context, ) .user?.image;
   final items = Provider.of<ItemModel>(context);
    return Scaffold(
      appBar: AppBar(

        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));

        }, icon: profileImage ==null? Icon(Icons.account_box) : CircleAvatar(child: ClipOval(child: Image.file(profileImage,
          fit: BoxFit.cover,
          height: 50,width: 50,),),))],
        centerTitle: true,
        title: Text("The ${items.selectedItem!.title}"),
      ),
      body: SingleChildScrollView(
        child:Column(
            children: [
              //image == null || image!.isEmpty ? Image.asset("assets/Tree.jpg"):
                   Image.file(items.selectedItem!.images.first,height: 300,fit: BoxFit.cover,width: double.infinity,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FavoriteWidget(index: items.items.indexOf(items.selectedItem!),),
                  IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        textAlign: TextAlign.left,
                        style:TextStyle(fontWeight: FontWeight.bold),
                        "Description:"

                      //?? "Trees are very important for our planet. They give us clean air to breathe by taking in carbon dioxide and releasing oxygen. Trees provide homes for many animals like birds, squirrels, and insects. They also give us fruits, nuts, and wood that we use in our daily lives. Trees help cool the environment by providing shade and releasing water vapor into the air. They prevent soil erosion by holding the soil together with their roots. In cities, trees make the surroundings more beautiful and peaceful. They also help reduce noise and can make us feel happier and more relaxed. Planting and caring for trees is a great way to help the Earth and all the living things on it."
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        textAlign: TextAlign.justify,
                        style:TextStyle(),
                        items.selectedItem!.body

                      //?? "Trees are very important for our planet. They give us clean air to breathe by taking in carbon dioxide and releasing oxygen. Trees provide homes for many animals like birds, squirrels, and insects. They also give us fruits, nuts, and wood that we use in our daily lives. Trees help cool the environment by providing shade and releasing water vapor into the air. They prevent soil erosion by holding the soil together with their roots. In cities, trees make the surroundings more beautiful and peaceful. They also help reduce noise and can make us feel happier and more relaxed. Planting and caring for trees is a great way to help the Earth and all the living things on it."
                    ),

                  ),
                ],
              )
              , Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        textAlign: TextAlign.left,
                        style:TextStyle(fontWeight: FontWeight.bold),
                        "Price: "

                      //?? "Trees are very important for our planet. They give us clean air to breathe by taking in carbon dioxide and releasing oxygen. Trees provide homes for many animals like birds, squirrels, and insects. They also give us fruits, nuts, and wood that we use in our daily lives. Trees help cool the environment by providing shade and releasing water vapor into the air. They prevent soil erosion by holding the soil together with their roots. In cities, trees make the surroundings more beautiful and peaceful. They also help reduce noise and can make us feel happier and more relaxed. Planting and caring for trees is a great way to help the Earth and all the living things on it."
                    ),
                  ),Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        textAlign: TextAlign.justify,
                        style:TextStyle(),
                        items.selectedItem!.price

                      //?? "Trees are very important for our planet. They give us clean air to breathe by taking in carbon dioxide and releasing oxygen. Trees provide homes for many animals like birds, squirrels, and insects. They also give us fruits, nuts, and wood that we use in our daily lives. Trees help cool the environment by providing shade and releasing water vapor into the air. They prevent soil erosion by holding the soil together with their roots. In cities, trees make the surroundings more beautiful and peaceful. They also help reduce noise and can make us feel happier and more relaxed. Planting and caring for trees is a great way to help the Earth and all the living things on it."
                    ),
                  ),
                ],
              ),
          //   image == null || image!.isEmpty ? Row( //lw empty hy3rd el row
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //  children: [
                //  MySeason(url: "assets/Spring.jpg", text: "Spring"),
                 // MySeason(url: "assets/Fall.jpg", text: "Fall"),
               // ],
             // ):
                 //b7ded 3dad el elements ely hyt3rd w el size ely ben kol element w el tany
                 SizedBox(
                   height: 500,
                   child: GridView.builder(
                     //3dad el sowar howa length el list
                     itemCount: items.selectedItem!.images.length,
                     //ely hy3rd el shakl
                     itemBuilder: (context, index) =>
                         Image.file(items.selectedItem!.images[index],height: 200,width: 200,fit: BoxFit.cover,),
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                       mainAxisSpacing: 10,crossAxisSpacing: 10,)),
                 )
        ],),
        ),



      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddItemScreen()));

        },
        child: Icon(Icons.add),
      )
    );

  }
}
//nfsl ben el logic w el file

