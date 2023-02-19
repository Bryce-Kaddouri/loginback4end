import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todoapponline/screens/muscu/muscu.dart';

class AddExo extends StatefulWidget {
  final ParseUser user;
  final Map<String, dynamic> train;

  AddExo({super.key, required this.user, required this.train});

  @override
  State<AddExo> createState() => _AddExoState();
}

class _AddExoState extends State<AddExo> {
  List exos = [];

  Future<void> updateExo(String id, List<dynamic> exos) async {
    var todo = ParseObject('Training')
      ..objectId = id
      ..set('taches', exos);
    ParseResponse response = await todo.save();

    if (response.success) {
      print('success');
      // dissmiss the keyboard
      FocusScope.of(context).unfocus();
      // show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Exo added'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      print('error');
      // show error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(response.error!.message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    print(response.success);
    print(response.result);
    print(response.error);
  }

  @override
  initState() {
    super.initState();
    // var query = QueryBuilder<ParseObject>(ParseObject('Training'))
    //   ..whereEqualTo('objectId', widget.train['objectId']);

    // query.query().then((value) {
    //   print('old taches -----------------------------');
    //   print(value.results![0].get('taches'));
    //   exos = value.results![0].get('taches');
    //   setState(() {
    //     exos.insertAll(
    //         0, value.results![0].get('taches').map((e) => e.toJson()));
    //   });
    // });

    // print('initState');
    // print(exos);
    // print('-------------------------------------------------');
    // print(oldExos.length);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> oldExos = widget.train['taches'];
    int lstSize = oldExos.length;

    print(exos);
    // global key for the form
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    // controller for title
    final TextEditingController _titleController = TextEditingController();
    // controller for description
    final TextEditingController _descriptionController =
        TextEditingController();
    final TextEditingController _poidsController = TextEditingController();
    final TextEditingController _repetitionsController =
        TextEditingController();
    final TextEditingController _duree = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exo'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                keyboardAppearance: Brightness.dark,
                keyboardType: TextInputType.text,
                controller: _titleController,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Titre',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _poidsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Poids',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _duree,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Duree',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    print(_titleController.text);
                    print(_descriptionController.text);
                    print(_poidsController.text);
                    print(_duree.text);
                    print(widget.train['objectId']);

                    // convert the string to a list of strings to json
                    final Map<String, dynamic> exo = {
                      'titre': _titleController.text,
                      'description': _descriptionController.text,
                      'poids': _poidsController.text,
                      'timer': _duree.text,
                    };
                    oldExos.insert(lstSize, exo);

                    print(
                        '--------------------------- add exo -----------------------------');
                    print(exos);
                    print('-------------------------------------------------');
                    print(oldExos.length);
                    print(oldExos);

                    updateExo(widget.train['objectId'], oldExos);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MuscuScreen(
                    //       user: widget.user,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Text('Ajouter'))
            ],
          ),
        ),
      ),
    );
  }
}
