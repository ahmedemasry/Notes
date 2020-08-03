import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_app/models/user.dart';
import 'package:login_app/ui/screens/image_pick.dart';



class AppDrawer extends StatefulWidget {
  final uid;
  String imageUrl;
  AppDrawer(this.uid);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: StreamBuilder<Object>(
                  stream: User.getUserDocumentFromFirebase(widget.uid),//Firestore.instance.collection('users').document(widget.uid).snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) return CircularProgressIndicator();
                    // ignore: unnecessary_statements
                    DocumentSnapshot documentSnapshot = snapshot.data;
                    switch(snapshot.connectionState)
                    {
                      case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
                      default: return Text(documentSnapshot.data['name']);
                    }
                      return Center(child: Text(snapshot.data));
                  },
                ),
              accountEmail: FutureBuilder(
              future: User.getUserEmail(widget.uid),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  return Text(snapshot.data ?? "");
                },),
              currentAccountPicture: StreamBuilder<Object>(
                stream: User.getUserDocumentFromFirebase(widget.uid),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return CircleAvatar(foregroundColor: Theme.of(context).primaryColorDark,child: Text('A', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)));
                    DocumentSnapshot documentSnapshot = snapshot.data;
                    widget.imageUrl = documentSnapshot.data['profilePicture'];

                  return documentSnapshot.data['profilePicture']==null
                      ?CircleAvatar(foregroundColor: Theme.of(context).primaryColorDark,child: Text('A', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),))
                      :CircleAvatar(backgroundImage:NetworkImage(widget.imageUrl),);
                }
              ),
            ),
//            Divider(color: Theme.of(context).primaryColorLight,),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Set Profile Picture'),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImagePick(uid: widget.uid,imageUrl: widget.imageUrl,)));
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}