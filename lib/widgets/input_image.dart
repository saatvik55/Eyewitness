import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ImageInputState createState() => _ImageInputState(File(""));
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  _ImageInputState(this._storedImage);
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.saveTo('${appDir.path}/$fileName');
    // print("_takePicture");
    // print(==null);
    widget.onSelectImage(File(imageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          // ignore: unnecessary_null_comparison
          child: _storedImage.path != ""
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.browse_gallery),
            label: const Text('Upload Picture'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).primaryColor)
                ),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
