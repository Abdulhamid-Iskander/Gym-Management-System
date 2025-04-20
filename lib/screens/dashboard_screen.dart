import 'package:flutter/material.dart';
import 'package:gym_management_app/widgets/custom_drawer.dart'; // حسب مكان ملفك

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1E6F),
        title: const Text("Dashboard"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: const CustomDrawer(
        adminName: "CaesAr",
        adminEmail: "caesar@gmail.com",
      ),
      body: const Center(
        child: Text(
          'Welcome to Dashboard',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
