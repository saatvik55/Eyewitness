import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/event_model.dart';

class MapScreen extends StatefulWidget {
  final EventLocation initialLocation;
  final bool isSelecting;
  
 MapScreen({
    required this.initialLocation,
    this.isSelecting = false,
  });
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation = LatLng(0.0, 0.0);
  final apiKey= "CoJgb2yAHy9oHtvsbKunimAe0Jm8toeP";
  
  void _selectLocation(tapPosition,LatLng position){
          setState(() {
            print("In selectlocation function");
            print("tapposition is : $tapPosition , and position is : $position");
            _pickedLocation = position;
          });
  }
  
  
  @override
  Widget build(BuildContext context) {
    print("isSelecting is : ${widget.isSelecting}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Map"),
        actions: <Widget>[
          if(widget.isSelecting) IconButton(
            onPressed: _pickedLocation.latitude==0.0 && _pickedLocation.longitude==0.0 ? null
             :() {
              print("picked Location is : ${_pickedLocation.latitude} , ${_pickedLocation.longitude}");
              Navigator.of(context).pop(_pickedLocation);
            }, 
            icon: const Icon(Icons.check
            )
            )
        ],
      ),
      body:Center(
            child: Stack(
              children: <Widget>[
                FlutterMap(
                  options: MapOptions(
                    center: LatLng(widget.initialLocation.latitude,widget.initialLocation.longitude), 
                    minZoom: 1.0,
                    maxZoom: 80.0,
                    onTap: widget.isSelecting ?  _selectLocation: null,
                    
                    ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                          "{z}/{x}/{y}.png?key={apiKey}",
                      additionalOptions: {"apiKey": apiKey},
                    ),
                    MarkerLayer(
                          markers: [
                           Marker(
                             width: 80.0,
                             height: 80.0,
                             point: LatLng(widget.initialLocation.latitude,widget.initialLocation.longitude),
                             builder: (BuildContext context) => const Icon(
                                 Icons.location_on,
                                 size: 60.0,
                                 color: Colors.black),
                           ),
                         ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(     
                  alignment: Alignment.bottomLeft,
                  width: 150,
                  child: Image.asset("assets/images/TomTom.png")),
                    )
                  ],
                )
              ],
            )
            )
      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(
      //       widget.initialLocation.latitude,
      //       widget.initialLocation.longitude,
      //     ),
      //     zoom: 16,
      //     ),
          // onTap: widget.isSelecting ?  _selectLocation: null,
          // markers: (_pickedLocation == null && widget.isSelecting)? {} : {
          //   Marker(
          //   markerId: MarkerId('m1'),
          //   position: _pickedLocation ?? 
          //   LatLng(
          //     widget.initialLocation.latitude, 
          //     widget.initialLocation.longitude
          //     ),
          //   ),
          // },
      //   ),
      
    );
  }
}