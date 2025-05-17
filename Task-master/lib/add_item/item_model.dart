import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'item.dart';

class ItemModel extends ChangeNotifier {

 final List<Item> _items = [] ;

  List<Item> get items => _items;

  void addItem(Item item){

    _items.add(item);
    notifyListeners(); //kol ma azwd 7aga a7otha
  }


  //Gbt nfs el function rly kant mawgoda fe profile page
//w 3dlt 3leha bdl ma akhtar sora wa7da akhtar kza sora

  List<File> ? selectedImage = [];
  //1.b3d ma ageb list el images h7wel kol path le sora le file
  //2.akhzno fl list ely mn no3 file
  //h7wel el list de mn list files le list mn el images(widgets) 3shan tt3rd
  ImagePicker imagePicker = ImagePicker();

  //b3d ma gbt el sora hkhznha gowa el file
  Future <void> imageSelector( ) //hnady 3leha marten mara lel gallery w mara lel camera
  async{
    List<XFile> ? images= await imagePicker.pickMultiImage(); // nkhzn el sowar ely gbnaha mn el gallery
    //hkhzn fe list mn no3 xFile 3shan howa hyrg3ly list
    // el sowar lesa hstnaha 3shan a3mlha store
    if(images != null ) //bt2kd en el screen lesa mawgoda bl tree bta3t el widget
        {
      //el set state hya el qema el tnya ely httl3 3ndy lw msh null

        selectedImage!.addAll(images.map((toElement) => File(toElement!.path)).toList()); //msh by2bl null
      //a7wel el path le file

      //selectedImage = File(image!.path); // el sora ely ana estkhdmtha bl path bta3ha != null
    }
    notifyListeners();
  }
void removeImage ( index ){
    selectedImage!.removeAt(index);
notifyListeners();
}

 Item ? _selectedItem;
 Item ? get selectedItem => _selectedItem;

 void selectItem(Item item){
   _selectedItem = item;
   notifyListeners();

 }


}