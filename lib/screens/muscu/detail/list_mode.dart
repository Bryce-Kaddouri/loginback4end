import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ListModeDetailMuscu extends StatefulWidget {
  const ListModeDetailMuscu(
      {super.key, required this.user, required this.train});

  final ParseUser user;
  final Map<String, dynamic> train;

  @override
  State<ListModeDetailMuscu> createState() => _ListModeDetailMuscuState();
}

class _ListModeDetailMuscuState extends State<ListModeDetailMuscu> {
  List<Map<String, dynamic>> details = [];
  List<Map<String, dynamic>> taches = [];

  @override
  initState() {
    super.initState();
    Future currentUser = ParseUser.currentUser();
    print(currentUser.toString());

    currentUser.then((value) {
      var query = QueryBuilder<ParseObject>(ParseObject('Training'))
        ..whereEqualTo('objectId', widget.train['objectId']);

      query.query().then((value) {
        setState(() {
          details.insertAll(0, value.results!.map((e) => e.toJson()));
          // taches.insertAll(0, value.results!.map((e) => e.toJson()));
        });
      });

      // taches = details[0]['taches'];

      if (value == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List taches = widget.train['taches'];
    print('************************************');
    print(taches);
    if (taches.length > 0) {
      return ListView.builder(
        itemCount: taches.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              tileColor: Colors.blueGrey[50],
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: 4),
              title: Text(
                taches[index]['titre'],
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                taches[index]['id'],
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        child: Text('ListModeDetailMuscu'),
      );
    }
  }

  // function to get the list of taches
}
