import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mert_karakis_web/firebase_configurations.dart';
import 'package:mert_karakis_web/global.dart';
import 'package:mert_karakis_web/pages/main_view.dart';

Future<void> main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: Configurations.apiKey,
    appId: Configurations.appId,
    messagingSenderId: Configurations.messagingSenderId,
    projectId: Configurations.projectId,
    storageBucket: Configurations.storageBucket,
  ));
  await appPageStore.getPageModels();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mertkarakis.dev',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MainPage(),
    );
  }
}
