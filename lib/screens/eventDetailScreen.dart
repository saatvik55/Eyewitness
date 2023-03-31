import 'package:flutter/material.dart';
import 'package:myflutterproject/provider/user/greatEvents.dart';
import 'package:myflutterproject/widgets/mainDrawer.dart';
import 'package:provider/provider.dart';

import '../models/event_model.dart';
import 'map_screen.dart';




class EventDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final Event selectedPlace = Provider.of<GreatEvents>(context, listen: false).findById(id.toString());    
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Text(selectedPlace.title),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
              ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(selectedPlace.description),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => 
                    MapScreen(
                      initialLocation: selectedPlace.location,
                      isSelecting: false,
                    ) 
                    )
                );
              }, 
              child: Text('View on Map'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
              )
              )
        ],
      ),
    );
  }
}