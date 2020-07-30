import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_app/ui/widgets/original_button.dart';

class ImagePick extends StatefulWidget {
  final uid;

  const ImagePick({Key key, this.uid}) : super(key: key);
  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {

  File _image;
  final picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Set Profile Picture"),),),
        body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: min(MediaQuery.of(context).size.width/4, MediaQuery.of(context).size.height/5),
                    backgroundImage:_image == null ? null : FileImage(_image),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add_a_photo), onPressed: () => getImage(true),
                        iconSize: min(MediaQuery.of(context).size.width/8, MediaQuery.of(context).size.height/8),
                      ),
                      IconButton(
                          icon: Icon(Icons.image), onPressed: () => getImage(false),
                          iconSize: min(MediaQuery.of(context).size.width/8, MediaQuery.of(context).size.height/8),
                      ),
                    ],
                  ),
//                  OriginalButton(bgColor: Colors.blue,textColor: Colors.white,text: "import from gallery",
//                  onPressed: () => getImage(false),),
                ],
              ),
            ),
          ),
        )
    );
  }
  Future getImage(bool camera) async {
//    File pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final pickedFile = await picker.getImage(source: camera ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
}
