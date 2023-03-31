import 'dart:io';
import 'package:myflutterproject/models/event_model.dart';
import 'package:myflutterproject/screens/police_Screen.dart';
import 'package:myflutterproject/widgets/input_image.dart';
import 'package:myflutterproject/widgets/location_input.dart';
import 'package:myflutterproject/widgets/mainDrawer.dart';
import '../provider/user/greatEvents.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/src/material/dropdown.dart';

class AddEventScreen extends StatefulWidget {
  static const routeName = "/add-Event";

  const AddEventScreen({super.key}); 
  
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _AddEventScreenState createState() => _AddEventScreenState(File("assets/images/humanface.png"),const EventLocation("",0.0,0.0));
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _incidentController = TextEditingController();
  final _descriptionController = TextEditingController();
  // String? _incidentType="Incident";
  File _pickedImage;
  EventLocation _pickedLocation ;
  List<String> options = [
                  'Road Accident',
                  'Road Rage',
                  'Child Trafficking',
                  'Women Exploitation'
                  'Natural Disaster',];


  _AddEventScreenState(this._pickedImage,this._pickedLocation);
  void _selectImage(File pickedImage)
  {
    // print("_selectImage");
     _pickedImage = pickedImage;
  }

  void _saveEvent(BuildContext ctx) {
    print("save Event 1");
    // print(_pickedImage==null);

     if(_incidentController.text.isEmpty){
       return;
     }
     Provider.of<GreatEvents>(context,listen: false).addEvent(
     _descriptionController.text,
     _incidentController.text, 
     _pickedImage, 
     _pickedLocation
     );
      // print("save Event");
     Navigator.of(ctx).pushReplacementNamed(PoliceScreen.routeName);
  }
  

  void _selectEvent(double lat, double lng)
  {
    
     _pickedLocation = EventLocation("", lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    print("In the build of add");
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text("Add a new Event"
        ),
      ),
      body: Column( 
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                   TextField(
                    decoration: const InputDecoration(
                      labelText: 'Incident Type',  
                      ),
                      controller: _incidentController,
                   ),
                   const SizedBox(height: 10),
                   ImageInput(_selectImage),
                   const SizedBox(
                    height: 10,
                   ),
                   LocationInput(_selectEvent),
                   const SizedBox(height: 10,),
                   Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16),
                   child: TextField(
                   controller: _descriptionController,
                   decoration: const InputDecoration(
                   labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ),
                  ],
                ),
              ),
            ),
          ),
          // Text("User Inputs ..."),
           ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("Add Event"),
            onPressed: () => _saveEvent(context),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
              ),
            )
        ],
      ),
    );
  }
}