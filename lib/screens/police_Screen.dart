import 'package:flutter/material.dart';
import 'package:myflutterproject/screens/addEvent.dart';
import 'package:myflutterproject/screens/eventDetailScreen.dart';
import 'package:myflutterproject/widgets/mainDrawer.dart';
import 'package:provider/provider.dart';
import '../provider/user/greatEvents.dart';
import '../models/event_model.dart';


class PoliceScreen extends StatelessWidget {
  static const routeName="/police";
  const PoliceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('Jaipur Police'),
        actions: const <Widget>[
          Icon(Icons.local_police),
        ],
      ),
      body: Stack(
        children: [FutureBuilder(
          future: Provider.of<GreatEvents>
          (context, listen: false).fetchAndSetEvents(),
          builder: (ctx, snapshot) =>snapshot.connectionState == ConnectionState.waiting
          ? const Center(child:CircularProgressIndicator())
          : Consumer<GreatEvents>(
            child: const Center(
              child: Text('Got no events yet, start adding some!'),
            ),
            builder: (ctx, greatEvents, ch) => greatEvents.items.isEmpty
                ? ch!
                : ListView.builder(
                    itemCount: greatEvents.items.length,
                    itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatEvents.items[i].image,
                            ),
                          ),
                          title: Text(greatEvents.items[i].title),
                          subtitle: Text(greatEvents.items[i].location.address
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              EventDetailScreen.routeName,
                              arguments: greatEvents.items[i].id,
                              );
                          },
                        ),
                  ),
          ),
        ),
        // Positioned(
        //     bottom: 16.0, // adjust as needed
        //     right: 16.0, // adjust as needed
        //   child: FloatingActionButton(
        //     onPressed:() {
        //         // Navigator.of(context).pushReplacement(newRoute)
        //         Navigator.of(context).pushNamed(AddEventScreen.routeName);
        //       },
        //     elevation: 8.0,
        //     child: const Icon(Icons.add),
        //     ),
        // ),
        ]
      ),
    );
  }
}
