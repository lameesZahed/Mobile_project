import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/add_item/item.dart';
import 'package:task/add_item/item_model.dart';
import 'package:task/dashboard/dashboard_screen.dart';
import 'package:task/main.dart';
import 'package:provider/provider.dart';
import '../details/details_screen/details_page.dart';

class AddItemScreen extends StatefulWidget {
  AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {



  TextEditingController title = TextEditingController();
  //save the data
  TextEditingController body = TextEditingController();
  TextEditingController price = TextEditingController();



  @override
  void dispose() {
    title.dispose();
    body.dispose();
    price.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  //awel ma atla3 mn el screen htthdm f el mafrod ahdm m3aha el controller 3shan mysrbsh el data
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,

      ),
      body: MergeSemantics(
        child: Container(
          decoration: BoxDecoration(
        
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/background.jpg"))
          ),
        
          child: Consumer <ItemModel>(
            builder: (context, itemModel, child) =>
             ListView(children: [ //ghyrt mn column le listview 3shan a2dr a3ml scroll
              SizedBox( height: 30 ,) // el msa7a ely mn fo2
              ,
              //lw el list fadya hyrg3 container
               itemModel.selectedImage!.isEmpty ? Container(
        
                color: Colors.white38,
                height: 150,width: MediaQuery.sizeOf(context).width-20,
                child: IconButton(onPressed: (){
                  itemModel.imageSelector();
        
                }, icon: Icon(Icons.camera_alt)),)
                : //3yza lw 3ndy image already a2dar akhtar sowar tnya
              Row(
                children: [
        
                  Container(
        
                    color: Colors.white38,
                    height: 100,width: 100,
                    child: IconButton(onPressed: (){
                      itemModel.imageSelector();
        
                    }, icon: Icon(Icons.camera_alt)),),
        
        
        
                  SizedBox(
                    height: 100,
                      width: MediaQuery.sizeOf(context).width-120,
                      child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:itemModel.selectedImage!.map((toElement) => Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.file(toElement , height: 100, width: 100, fit: BoxFit.cover,),
                          ),
                          //el list bta3t el images
                          IconButton(onPressed: (){
                              //a3ml remove lel images ely 3ndy
                           itemModel.removeImage(itemModel.selectedImage!.indexOf(toElement));
                          }, icon: Icon(Icons.cancel))
                        ],
                      )
                      ).toList(),),
                    ),
                ],
              ),
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                      hintText: "title",
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: body,
                  minLines: 3,
                  maxLines: 7,
                  decoration: InputDecoration(
                      hintText: "body",
                      border: OutlineInputBorder()
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextField(
                   controller: price,
                   decoration: InputDecoration(
                       hintText: "price",
                       border: OutlineInputBorder()
                   ),
                 ),
               ),

        
            ],),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),


          onPressed: (){

            final item = Provider.of<ItemModel>(context , listen: false);
            //msh m7tagen listen le ay taghyeer

            item.addItem(Item(
                images: List.from(item.selectedImage!) ,
                title: title.text,
                body: body.text,
                favorite: false,
                price: price.text

            ));

            item.selectedImage!.clear(); //ams7 mol 7aga feha

             Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardScreen())) ;

            //.pushreplacement => mfesh zorar back

          }),//amrar el data lel screen el tanya

    );
  }
}

