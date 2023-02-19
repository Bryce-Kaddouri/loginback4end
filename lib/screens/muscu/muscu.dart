import 'package:flutter/material.dart ';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todoapponline/screens/muscu/detail/detail_session.dart';

class MuscuScreen extends StatefulWidget {
  final ParseUser user;
  MuscuScreen({super.key, required this.user});

  @override
  State<MuscuScreen> createState() => _MuscuScreenState();
}

class _MuscuScreenState extends State<MuscuScreen> {
  List<Map<String, dynamic>> allTraining = [];

  @override
  initState() {
    super.initState();
    Future currentUser = ParseUser.currentUser();
    print(currentUser.toString());

    currentUser.then((value) {
      var query = QueryBuilder<ParseObject>(ParseObject('Training'))
        ..orderByDescending('createdAt');

      query.query().then((value) {
        setState(() {
          allTraining.insertAll(0, value.results!.map((e) => e.toJson()));
        });
      });

      if (value == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(allTraining);
    int length = allTraining.length;
    print(length);

    // widget to scroll down and up to see all the training session ==>

    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Muscu'),
          Text(widget.user.username!),
          for (var i = 0; i < length; i++)
            Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  print('test');
                  var query = QueryBuilder<ParseObject>(ParseObject('Training'))
                    ..whereEqualTo('objectId', allTraining[i]['objectId']);

                  query.query().then((value) {
                    var train = value.results![0].toJson();
                    // redirect to the training session focus on the training session
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMuscuScreen(
                          user: widget.user,
                          train: train,
                        ),
                      ),
                    );
                  });

                  print(allTraining[i]['objectId']);
                },
                tileColor: Colors.blueGrey,
                title: Text(allTraining[i]['titre']),
                subtitle: Text(allTraining[i]['createdAt']),
                leading: Icon(Icons.fitness_center),
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
                      deleteTraining(allTraining[i]['objectId']);
                    }
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  void deleteTraining(String objectId) {
    var query = QueryBuilder<ParseObject>(ParseObject('Training'))
      ..whereEqualTo('objectId', objectId);

    query.query().then((value) {
      value.results![0].delete().then((value) {
        print(value);
        // refresh page
        setState(() {});
      });
    });
  }
}
