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
  List<Map<String, dynamic>>? details = [];
  List<Map<String, dynamic>?> taches = [];

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
          details!.insertAll(0, value.results!.map((e) => e.toJson()));
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
    return taches.isEmpty
        ? const Text(
            'Aucun exercice appuyer sur (+) pour ajouter un exercice !')
        : ListView.builder(
            itemCount: taches.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 226, 225, 225),
                  boxShadow: const [
                    BoxShadow(
                      // color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Colors.blueGrey,
                  title: Text(taches[index]!['titre'],
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  subtitle: Text(taches[index]!['description'],
                      style: const TextStyle(color: Colors.black54)),
                  leading: const Icon(Icons.fitness_center,
                      size: 40, color: Colors.black87),
                  // icon 3 points
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: "edit",
                        child: Text('Modifier'),
                      ),
                      PopupMenuItem(
                        value: "delete",
                        child: Text('Supprimer'),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == "edit") {
                        print('edit');
                      } else if (value == "delete") {
                        print('delete');
                      }
                    },
                  ),
                ),
              );
            });
  }

  // function to get the list of taches
}
