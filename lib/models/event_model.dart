import 'package:flutter/foundation.dart';
import 'dart:io';


class EventLocation {
  final double latitude;
  final double longitude;
  final String address;

   const EventLocation(
    this.address,
    @required this.latitude,
    @required this.longitude,
    );
}

class Event {
  final String id;
  final String description;
  final String title;
  final EventLocation location;
  final File image;

  Event({
    required this.id,
    this.description="",
    required this.title,
    required this.location,
    required this.image,
  });

  get items => null;
}