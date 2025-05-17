import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/favorite/favorite_model.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

        title: Text("Favorite")

        ,),

      body: Consumer<FavoriteModel>(
          child: Center(child: Text("No Items")),

          builder: (context, fav, child)

        {
          if(fav.fav.isNotEmpty) {

            return
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10
            ),
            itemCount: fav.fav.length,
            //el 3adad hyb2a 3la 7asab el 3dad bta3 el list

            itemBuilder: (context, index) {
              return SizedBox(child: Column(children: [

                Image.file(fav.fav[index].images.first, height: 125,
                  width: 125,
                  fit: BoxFit.cover,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //el space benhom
                  children: [
                    Text(fav.fav[index].title),
                    IconButton(onPressed: () {
                      fav.fav[index].favorite = false;
                      fav.remove(fav.fav[index]);
                    }, icon: Icon(Icons.favorite, color: Colors.red,))
                  ],
                )

              ],),);
            },
          );}

        else{

          return child!;
      }
  }
    ),);
  }
}
