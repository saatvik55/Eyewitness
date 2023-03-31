import 'dart:convert';
import 'package:http/http.dart' as http;

const TOMTOM_API_KEY = 'CoJgb2yAHy9oHtvsbKunimAe0Jm8toeP';
class LocationHelper {


  static String generateLocationPreviewImage(double latitude, double longitude) {
    print("In Location Helper");
    return "https://api.tomtom.com/map/1/staticimage?layer=basic&style=main&format=png&zoom=15&center=$longitude%2C%20$latitude&width=512&height=512&view=IN&key=$TOMTOM_API_KEY";
  }



  static Future<String> getPlaceAddress (double lat, double lng) async {
    var url = Uri.parse("https://api.tomtom.com/search/2/reverseGeocode/$lat,$lng.json?key=$TOMTOM_API_KEY&radius=100");
    print("Inside Location Helper");
    final response =await http.get(url);
    print("response is : $response");
    return jsonDecode(response.body)['addresses'][0]['address']['freeformAddress'];
  }
}