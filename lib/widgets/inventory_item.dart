import 'package:flutter/material.dart';

class InventoryItem extends StatelessWidget {
  final String name;
  final int quantity;
  final String status;

  const InventoryItem({
    super.key,
    required this.name,
    required this.quantity,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text("Quantity: $quantity | Status: $status"),
        trailing: Icon(
          status == "Available" ? Icons.check_circle : Icons.warning,
          color: status == "Available" ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}