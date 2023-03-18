// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);
  final void Function(File pickedImage) imagePickFn;
  
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
   File _pickedImage = new File("assets/images/humanface.png"); 
   ImageProvider imageProvider = AssetImage("assets/images/humanface.png");
  



  void _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      print(pickedImageFile!.path);
      _pickedImage = new File(pickedImageFile.path);
      imageProvider= FileImage(_pickedImage);
    });
    widget.imagePickFn(_pickedImage);
  }





  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      backgroundImage: imageProvider,
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColorDark),
                      ),
                      onPressed: _pickImage,
                      icon: Icon(Icons.image), 
                      label: Text('Add Image'),
                      ),
      ],
    );
  }
}