import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todoapponline/screens/muscu/muscu.dart';

class AddSession extends StatefulWidget {
  final ParseUser user;

  AddSession({super.key, required this.user});

  @override
  State<AddSession> createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  @override
  Widget build(BuildContext context) {
    // global key for the form
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    // controller for title
    final TextEditingController _titleController = TextEditingController();
    // controller for description
    final TextEditingController _descriptionController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Session'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Form(
          child: Column(
            children: [
              TextFormField(
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
                controller: _descriptionController,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    print(_titleController.text);
                    print(_descriptionController.text);

                    var session = ParseObject('Training')
                      ..set('titre', _titleController.text)
                      ..set('description', _descriptionController.text);
                    // atach the trqining to the user who created it (the current user)
                    // ..addRelation('idUser', widget.user);

                    var currentUser = ParseUser.currentUser()!;
                    var response = session.save();

                    currentUser.then((value) => response.then((value) {
                          print(value.success);
                          print(value.statusCode);

                          if (value.success) {
                            print('Session saved');
                            setState(() {
                              _titleController.clear();
                              _descriptionController.clear();
                            });

                            // add the new session to the list of sessions

                            // snack bar with a cross in the top right corner to close the snack bar
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                'Session saved',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ));
                          } else {
                            print('Session not saved');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Session not saved',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              backgroundColor: Colors.red,
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ));
                          }
                        }));
                    // session.save().then((response) {
                    //   print(response.success);
                    //   print(response.statusCode);

                    //   if (response.success) {
                    //     print('Session saved');
                    //   } else {
                    //     print('Session not saved');
                    //   }
                    // });

                    // ..set('user', widget.user);
                    // if (_formKey.currentState!.validate()) {
                    //   print(_titleController.text);
                    //   print(_descriptionController.text);
                    // }
                  },
                  child: Text('Ajouter'))
            ],
          ),
        ),
      ),
    );
  }
}
