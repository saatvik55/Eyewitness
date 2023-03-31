import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '/models/event_model.dart';
import '../screens/map_screen.dart';
import '../helpers/location_helper.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latlng;

class LocationInput extends StatefulWidget {
  // const LocationInput({Key key}) : super(key: key);
  final Function onselectPlace;
  LocationInput(this.onselectPlace);
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl="https://mms.businesswire.com/media/20180917005836/en/678859/5/TomTom_Logo_highres.jpg";

  void _showPreview(double lat, double lng){
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(lat, lng);
    print("In show preview");

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }




  Future<void> _selectOnMap() async {
  var locData;
  try {
    locData = await Location().getLocation();
    } catch (e) {
      print("Could not get current Location");
      return;
    }
  final latlng.LatLng selectedLocation = await Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => MapScreen(
        initialLocation: locData!=null?EventLocation("",locData.latitude,locData.longitude):const EventLocation("",26.933550, 75.816078),
        isSelecting: true,
      )
    ),
    );
  // ignore: unnecessary_null_comparison
  if(selectedLocation == null){
    return;
  }  
  print(selectedLocation.latitude);
  _showPreview(selectedLocation.latitude, selectedLocation.longitude);
  widget.onselectPlace(
    selectedLocation.latitude,
    selectedLocation.longitude
    );
}





  Future<void> _getCurrentUserLocation() async{
    print("reached get current function");
    try {
    final locData = await Location().getLocation();
      print("Current coordinates are: $locData.latitude , $locData.longitude");
    _showPreview(
      locData.latitude!, 
      locData.longitude!
      );
    // lat=locData.latitude;
    // lng=locData.longitude;
    // setState(() {});
    widget.onselectPlace(locData.latitude,locData.longitude);
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    print("In build of location input");
    print("Image url is : $_previewImageUrl"); 
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1, 
              color: Colors.grey
              ),
          ),
          child: _previewImageUrl== null ? Text("No Location Chosen",
          textAlign: TextAlign.center
          )
          :Image.network(_previewImageUrl, 
          fit: BoxFit.cover,
          width: double.infinity,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: _getCurrentUserLocation, 
              icon: Icon(Icons.location_on), 
              label: Text("Current Location"),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor), 
                  ),
              ),
              TextButton.icon(
                onPressed: _selectOnMap, 
                icon: Icon(Icons.map), 
                label: Text("Select on Map"),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor), 
                  ),
                )
          ],
        )
      ],
    );
  }
}



