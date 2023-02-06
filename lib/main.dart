import 'package:flutter/material.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todoapponline/screens/login/login.dart';
// http package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'H2IKWJa0fREs9I60bsMztESNp8PmE1a6PTZ6da3W';
  const keyClientKey = 'AeXGdeibFlJiJiQ8tbUdLqaItxnN2SloBPTz2b2M';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App Online',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      // initialRoute: SplashScreen().toString(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // global
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Splash Screen'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Go to Login Screen'),
            ),
          ],
        ),
      ),
    ));
  }
}
