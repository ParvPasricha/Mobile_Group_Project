import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/customer.dart';
import '../providers/customer_provider.dart';
import 'edit_customer_page.dart';

class CustomerDetailPage extends StatelessWidget {
  final Customer customer;

  CustomerDetailPage({required this.customer});

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete Customer'),
                    content: Text('Are you sure you want to delete this customer?'),
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
                Navigator.pop(context); // Close the detail page after deleting
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name: ${customer.firstName}'),
            Text('Last Name: ${customer.lastName}'),
            Text('Address: ${customer.address}'),
            Text('Birthday: ${customer.birthday}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditCustomerPage(customer: customer),
                  ),
                );
              },
              child: Text('Edit Customer'),
            ),
          ],
        ),
      ),
    );
  }
}
