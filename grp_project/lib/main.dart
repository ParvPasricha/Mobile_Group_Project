import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floor/floor.dart';
import 'database/app_database.dart';


import 'dao/customer_dao.dart';
import 'airplainListPage/dao/airplane_dao.dart';
import 'providers/customer_provider.dart';
import 'airplainListPage/providers/airplane_provider.dart';
import 'pages/customer_list_page.dart';
import 'airplainListPage/pages/airplane_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CustomerProvider(database.customerDAO),
        ),
        ChangeNotifierProvider(
          create: (_) => AirplaneProvider(database.airplaneDAO),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Instructions'),
                  content: Text('Instructions on how to use the application.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerListPage()),
                );
              },
              child: Text('Customer List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AirplaneListPage()),
                );
              },
              child: Text('Airplane List'),
            ),
            // Add more buttons here for other parts of the project
          ],
        ),
      ),
    );
  }
}
