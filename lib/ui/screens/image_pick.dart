import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_app/models/user.dart';
import 'package:login_app/ui/widgets/original_button.dart';
import 'package:path/path.dart';

class ImagePick extends StatefulWidget {
  final uid;
  final imageUrl;

  const ImagePick({Key key, this.uid, this.imageUrl}) : super(key: key);
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
              padding: const EdgeInsets.only(left: 50,right: 50),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: min(MediaQuery.of(context).size.width/4, MediaQuery.of(context).size.height/5),
                      backgroundImage: _image != null ? FileImage(_image): widget.imageUrl!=null ? NetworkImage(widget.imageUrl): null,
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
                    OriginalButton(bgColor: Colors.blue,textColor: Colors.white,text: "save",
                    onPressed: () {uploadImage();Navigator.pop(context);},),
                  ],
                ),
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

  uploadImage() async {
    try {
//      String oldUrl = widget.imageUrl;
//      print(oldUrl);
      FirebaseStorage firebaseStorage = FirebaseStorage(
          storageBucket: 'gs://intro-login-55167.appspot.com');
      StorageReference ref = firebaseStorage.ref().child(basename(_image.path));
      StorageUploadTask uploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      User.setProfilePicture(widget.uid, url);
//      FirebaseStorage(storageBucket: oldUrl).ref().delete();//firebaseStorage.ref().child(oldUrl).delete();
    }catch(e){
      print(e);
    }
  }
}
