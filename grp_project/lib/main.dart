import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/customer_provider.dart';
import 'pages/customer_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerProvider(),
      child: MaterialApp(
        title: 'Customer Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CustomerListPage(),
      ),
    );
  }
}
