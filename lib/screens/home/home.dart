import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todoapponline/screens/muscu/add/add_session.dart';
import 'package:todoapponline/screens/muscu/muscu.dart';
import 'package:todoapponline/screens/profil/profil.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.user});

  ParseUser user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Future currentUser = ParseUser.currentUser();
    // print(currentUser.toString());

    // currentUser.then((value) {
    //   if (value == null) {
    //     Navigator.pushReplacementNamed(context, '/login');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
        print(widget.user.sessionToken);
        print(widget.user.objectId);
      });
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          elevation: 10,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {},
            ),
          ]),
      body: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Home Screen'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _logout(widget.user);
                          },
                          child: const Text('Logout')),
                    ],
                  )),
            ],
          ),
        ),
        MuscuScreen(user: widget.user),
        const Center(
          child: Text('Recettes'),
        ),
        const ProfilScreen(),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          elevation: 10,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Sessions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.no_food),
              label: 'Recettes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.amber[800],
          onTap: ((value) {
            onTabTapped(value);
            print(value);
            print('current = $_currentIndex');
          })),
      floatingActionButton: _currentIndex == 0
          ? null
          : FloatingActionButton(
              onPressed: () {
                if (_currentIndex == 1) {
                  print('add session');
                  print(widget.user.sessionToken);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddSession(
                      user: widget.user,
                    );
                  }));
                }
              },
              tooltip: 'New Training',
              child: const Icon(Icons.add),
            ),
    ));
  }

  Future<void> _logout(ParseUser user) async {
    await user.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
