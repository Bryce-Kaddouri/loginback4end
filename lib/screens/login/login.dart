import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todoapponline/screens/home/home.dart';
import 'package:todoapponline/screens/register/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // route name
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  // controller for username
  final _usernameController = TextEditingController();
  // controller for email
  final _emailController = TextEditingController();
  // controller for password
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login Screen'),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
              SizedBox(height: 20),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                child: const Text('Singup ?'),
              ),
              ElevatedButton(
                onPressed: () async {
                  String username = _usernameController.text;
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  var user = ParseUser(username, password, email);
                  var response = await user.login();

                  if (response.success) {
                    print('success');
                    print(response.result.toString());

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          user: user,
                        ),
                      ),
                    );
                    // var response1 = await user.verificationEmailRequest();
                    // print(response1.success);
                    // ignore: use_build_context_synchronously

                  } else {
                    print(response.error!.message);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text(response.error!.message),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              )
                            ],
                          );
                        });
                  }

                  // print(username);
                  // print(password);
                  // print(email);
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
