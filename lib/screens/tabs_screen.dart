import 'package:flutter/material.dart';
import 'package:myflutterproject/screens/profile_screens/edit_description.dart';
import 'package:myflutterproject/screens/profile_screens/edit_email.dart';
import '/screens/addEvent.dart';
import '/screens/authScreen.dart';
import '/screens/eventDetailScreen.dart';
import '/screens/news_list_screen.dart';
import '/screens/police_Screen.dart';
import '/screens/profile_screens/edit_image.dart';
import '/screens/profile_screens/edit_phone.dart';
import '/screens/profile_screens/profile_page.dart';
import '../widgets/mainDrawer.dart';



class TabsScreen extends StatefulWidget {
  
  TabsScreen();
  @override
  TabsScreenState createState() =>  TabsScreenState();
}

class  TabsScreenState extends State <TabsScreen> {
  
  List <Map<String,Object>> _pages = [];
  
  int _selectedPageIndex = 0;

  void _selectPage(int index){
       setState(() {
           _selectedPageIndex = index;
       });
  }
  
  @override
  void initState() {
    _pages = [
    {'page': NewsListScreen(), 
     'title': 'News'
    },
    {'page': PoliceScreen(), 
     'title': 'Police Page'
    },
    {'page': AddEventScreen(), 
     'title': 'Add Events'
    },
    {'page': ProfilePage(), 
     'title': 'My Profile'
    },
    {'page': EventDetailScreen(), 
     'title': 'Detailed Screen'
    },
    {'page': EditDescriptionFormPage(), 
     'title': 'Detailed Screen'
    },
    {'page': EditEmailFormPage(), 
     'title': 'Detailed Screen'
    },
    {'page': EditImagePage(), 
     'title': 'Detailed Screen'
    },
    {'page': EditPhoneFormPage(), 
     'title': 'Detailed Screen'
    },
  ];
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title'].toString())),
        
        body: _pages[_selectedPageIndex]['page'] as Widget,
      );
  }
}