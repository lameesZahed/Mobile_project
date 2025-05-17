import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/profile/user.dart';

class UserModel extends ChangeNotifier {

  //File? selectedImage;

  User ? _user;
  User ? get user => _user;

  ImagePicker imagePicker = ImagePicker();

  //b3d ma gbt el sora hkhznha gowa el file
  Future <void> imageSelector(ImageSource source ) //hnady 3leha marten mara lel gallery w mara lel camera
  async{
    XFile ? image= await imagePicker.pickImage(source: source); // nkhzn el sowar ely gbnaha mn el gallery

    // el sowar lesa hstnaha 3shan a3mlha store
    if(image != null ) //bt2kd en el screen lesa mawgoda bl tree bta3t el widget
    {
      if (_user != null) {
        _user?.image = File(image!.path); // el sora ely ana estkhdmtha bl path bta3ha != null
      }

      else{

        _user = User (name: "Sama" , bio: "Code, Sleep, Eat, Repeat" , image:File(image!.path) );

      }

      notifyListeners();

    }
  }


 void removeImage (){

        _user?.image = null;
      notifyListeners();
    }
  }

