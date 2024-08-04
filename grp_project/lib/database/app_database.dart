import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import '../models/customer.dart';
import '../airplainListPage/models/airplane.dart';
import '../dao/customer_dao.dart';
import '../airplainListPage/dao/airplane_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Customer, Airplane])
abstract class AppDatabase extends FloorDatabase {
  CustomerDAO get customerDAO;
  AirplaneDAO get airplaneDAO;
}
