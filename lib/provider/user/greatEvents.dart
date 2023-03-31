import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import '../../helpers/dbHelper.dart';
import '../../helpers/location_helper.dart';
import '../../models/event_model.dart';


class GreatEvents with ChangeNotifier {
  List<Event> _items = [
    // Event(
    // id: "1", 
    // title: "Child Trafficking", 
    // location: const EventLocation("12 Rue de la République, 69001 Lyon, France",0.0,0.0), 
    // image: File("https://static.toiimg.com/imagenext/toiblogs/photo/blogs/wp-content/uploads/2018/06/CC18CB6D-A912-484D-BC4C-C5B4598E8730.jpg")
    // ),
    // Event(
    // id: "2", 
    // title: "Road Rage", 
    // location: const EventLocation("1600 Pennsylvania Ave NW, Washington, DC 20500, United States",0.0,0.0), 
    // image: File("https://th.bing.com/th/id/OIP.XKo5JwzwQWQc1jjEj30yOQHaEK?pid=ImgDet&rs=1")
    // ),
  ];

  List<Event> get items {
    return [..._items];
  }

  void addEvent (
    String description,
    String pickedTitle,
    File pickedImage,
    EventLocation pickedLocation,
  ) async {
    print("In add Event of great Events");
    final address = await LocationHelper.getPlaceAddress(
      pickedLocation.latitude
    , pickedLocation.longitude
    );
    print("Address is : $address");
    // const address= "masala Chowk";
    final updatedLocation = EventLocation(address, pickedLocation.latitude, pickedLocation.longitude);
    
    final newEvent = Event(
      id: DateTime.now().toString(),
      description: description,
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );


    _items.add(newEvent);
    notifyListeners();
    DBHelper.insert('user_Events', {
      'id': newEvent.id,
      'title': newEvent.title,
      'image': newEvent.image.path,
      'loc_lat': newEvent.location.latitude,
      'loc_lng': newEvent.location.longitude,
      'address': newEvent.location.address,
      });
  }

  Event findById(String id){
    return _items.firstWhere(
      (Event) => Event.id == id
      );
  }


  Future <void> fetchAndSetEvents() async {
    final dataList = await DBHelper.getData('user_Events');
    _items = dataList.map((item) => Event(
      id: item['id'], 
      title: item['title'], 
      location: EventLocation(
        item['address'], 
        item['loc_lat'], 
        item['loc_lng'],
        ), 
      image: File(item['image']),
      )
      ).toList();
      notifyListeners();
  }
}
