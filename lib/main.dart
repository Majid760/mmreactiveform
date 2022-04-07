import 'package:flutter/material.dart';
import 'package:mmreactiveform/HomePage.dart';
import 'package:mmreactiveform/controllers/image_controller.dart';
import 'package:mmreactiveform/database/database_service.dart';
import 'package:mmreactiveform/user_profile_list.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final _db = DatabaseService.instance.database;

  String? databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "reactiveformprofile.db");
  // Check if the database exists
  var exists = await databaseExists(path);
  if (!exists) {
    final _db = DatabaseService.instance.database;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImagePickerController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<ImagePickerController>(context).setDirectoryPath();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const HomePage()
      home: const UserProfileListing(),
    );
  }
}
