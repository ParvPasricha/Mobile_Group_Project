import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/airplane.dart';
import '../providers/airplane_provider.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddAirplanePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _passengerCountController = TextEditingController();
  final _maxSpeedController = TextEditingController();
  final _rangeController = TextEditingController();
  final _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final airplaneProvider = Provider.of<AirplaneProvider>(context);

    _loadPreviousData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Airplane'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Instructions'),
                  content: Text('Enter details of the airplane and press Add.'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter airplane type';
                  }
                  return null;
                },
                onChanged: (value) => _saveData('type', value),
              ),
              TextFormField(
                controller: _passengerCountController,
                decoration: InputDecoration(labelText: 'Passenger Count'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter passenger count';
                  }
                  return null;
                },
                onChanged: (value) => _saveData('passengerCount', value),
              ),
              TextFormField(
                controller: _maxSpeedController,
                decoration: InputDecoration(labelText: 'Max Speed'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter max speed';
                  }
                  return null;
                },
                onChanged: (value) => _saveData('maxSpeed', value),
              ),
              TextFormField(
                controller: _rangeController,
                decoration: InputDecoration(labelText: 'Range'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter range';
                  }
                  return null;
                },
                onChanged: (value) => _saveData('range', value),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final airplane = Airplane(
                      id: null,
                      type: _typeController.text,
                      passengerCount: int.parse(_passengerCountController.text),
                      maxSpeed: double.parse(_maxSpeedController.text),
                      range: double.parse(_rangeController.text),
                    );
                    airplaneProvider.addAirplane(airplane).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Airplane added successfully')),
                      );
                      Navigator.pop(context);
                    }).catchError((error) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content: Text('Failed to add airplane: $error'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    });
                  }
                },
                child: Text('Add Airplane'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  void _loadPreviousData() async {
    _typeController.text = await _storage.read(key: 'type') ?? '';
    _passengerCountController.text = await _storage.read(key: 'passengerCount') ?? '';
    _maxSpeedController.text = await _storage.read(key: 'maxSpeed') ?? '';
    _rangeController.text = await _storage.read(key: 'range') ?? '';
  }
}
