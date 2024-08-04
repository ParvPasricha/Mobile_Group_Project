import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/customer.dart';
import '../providers/customer_provider.dart';
import 'add_customer_page.dart';
import 'customer_detail_page.dart';

class CustomerListPage extends StatelessWidget {
  void _showAddCustomerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Customer'),
          content: Text(
              '1. Use the "Add Customer" button to add a new customer.\n'
                  '2. Tap on a customer in the list to view details.\n'
                  '3. Use the "Edit" option to update customer details.\n'
                  '4. You can also remove customers from the list.'
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCustomerPage()),
                ).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Customer added successfully!')),
                  );
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: customerProvider.customers.length,
              itemBuilder: (context, index) {
                final customer = customerProvider.customers[index];
                return ListTile(
                  title: Text('${customer.firstName} ${customer.lastName}'),
                  subtitle: Text(customer.address),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Delete Customer'),
                            content: Text('Are you sure you want to delete this customer data?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirmed == true) {
                        customerProvider.deleteCustomer(customer.id!);
                      }
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerDetailPage(customer: customer),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddCustomerDialog(context);
              },
              child: Text('Add Customer'),
            ),
          ),
        ],
      ),
    );
  }
}
