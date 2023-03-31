import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myflutterproject/screens/addEvent.dart';
import 'package:myflutterproject/screens/news_list_screen.dart';
import 'package:myflutterproject/screens/police_Screen.dart';
import 'package:myflutterproject/screens/profile_screens/profile_page.dart';



class MainDrawer extends StatelessWidget {

  Widget buildListTile(String title,IconData icon, VoidCallback tapHandler){
      return ListTile(
            leading: Icon(icon,
            size: 26,),
            title: Text(title,
            style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
            ),
            onTap: tapHandler,
          );
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).errorColor,
            alignment: Alignment.centerLeft,
            child: Text('Drawer',
            style:TextStyle(
              fontWeight:FontWeight.w900,
              fontSize: 30,
              color: Theme.of(context).primaryColor
              ),
            ),
          ),
          const SizedBox(height: 20,),
          buildListTile(
            'Police Screen',
            Icons.local_police,
            () {
           
              Navigator.of(context).pushReplacementNamed(PoliceScreen.routeName);
            }),
          buildListTile(
            'News Page',
            Icons.newspaper,
            () {
              Navigator.of(context).pushReplacementNamed(NewsListScreen.routeName);
            }
            ),
          buildListTile(
            'Profile Page',
            Icons.perm_identity,
            () {
              Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
            },
            ),
          buildListTile(
            'Report Event',
            Icons.messenger,
            () {
              Navigator.of(context).pushReplacementNamed(AddEventScreen.routeName);
            },
            ),
          buildListTile(
            'Signout',
            Icons.logout,
            () {
              FirebaseAuth.instance.signOut();
            },
            ),
        ],
      ),
    );
  }
}