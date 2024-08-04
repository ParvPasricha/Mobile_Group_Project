import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../database/app_database.dart';

class CustomerProvider extends ChangeNotifier {
  List<Customer> _customers = [];
  late final AppDatabase _database;

  CustomerProvider([customerDAO]) {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    _customers = await _database.customerDAO.findAllCustomers();
    notifyListeners();
  }

  List<Customer> get customers => _customers;

  Future<void> addCustomer(Customer customer) async {
    await _database.customerDAO.insertCustomer(customer);
    _customers = await _database.customerDAO.findAllCustomers();
    notifyListeners();
  }

  Future<void> updateCustomer(Customer customer) async {
    await _database.customerDAO.updateCustomer(customer);
    _customers = await _database.customerDAO.findAllCustomers();
    notifyListeners();
  }

  Future<void> deleteCustomer(int id) async {
    final customer = _customers.firstWhere((cust) => cust.id == id);
    await _database.customerDAO.deleteCustomer(customer);
    _customers = await _database.customerDAO.findAllCustomers();
    notifyListeners();
  }
}
