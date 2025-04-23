import 'package:flutter/material.dart';
import 'package:gym_management_app/constants/colors.dart';
import 'package:gym_management_app/models/drawer_item_model.dart';
import 'package:gym_management_app/screens/dashboard_screen.dart';
import 'package:gym_management_app/screens/coaches_screen.dart';
import 'package:gym_management_app/screens/plan_screen.dart';
// Import other screens as needed

class CustomDrawer extends StatefulWidget {
  final String adminName;
  final String adminEmail;
  final int indexPage;

  const CustomDrawer({
    super.key,
    required this.adminName,
    required this.adminEmail,
    required this.indexPage,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    // use indexPage 
    selectedIndex = widget.indexPage;
  }

  final List<DrawerItem> _drawerItems = [
    DrawerItem(
      icon: Icons.dashboard,
      title: 'Dashboard',
      screen: const DashboardScreen(),
    ),
    DrawerItem(
      icon: Icons.assignment,
      title: 'Plan',
      screen: const PlanScreen(),
    ),
    DrawerItem(
      icon: Icons.app_registration,
      title: 'Registration',
      screen: const Placeholder(), // لما تعمل الصفحه  Placeholder شيل ال 
    ),
    DrawerItem(
      icon: Icons.payment,
      title: 'Payment',
      screen: const Placeholder(), // لما تعمل الصفحه  Placeholder شيل ال 
    ),
    DrawerItem(
      icon: Icons.people,
      title: 'View Members',
      screen: const Placeholder(), // لما تعمل الصفحه  Placeholder شيل ال 
    ),
    DrawerItem(
      icon: Icons.inventory,
      title: 'Inventory',
      screen: const Placeholder(), // لما تعمل الصفحه  Placeholder شيل ال 
    ),
    DrawerItem(
      icon: Icons.fitness_center,
      title: 'Coaches',
      screen: const CoachesScreen(),
    ),
    DrawerItem(
      icon: Icons.analytics,
      title: 'Report',
      screen: const Placeholder(), // لما تعمل الصفحه  Placeholder شيل ال 
    ),
  ];

  void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: Column(
          children: [
            _buildProfileSection(),
            const Divider(color: AppColors.grayLight),
            _buildDrawerItemsList(),
            const Divider(color: AppColors.grayLight),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.white,
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.png',
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.adminName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.adminEmail,
            style: const TextStyle(color: AppColors.grayLight, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItemsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _drawerItems.length,
        itemBuilder: (context, index) {
          final item = _drawerItems[index];
          final isSelected = selectedIndex == index;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: isSelected
                ? BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  )
                : null,
            child: ListTile(
              leading: Icon(
                item.icon,
                color: isSelected ? AppColors.primary : AppColors.white,
              ),
              title: Text(
                item.title,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                navigateToScreen(context, item.screen);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: ListTile(
        leading: const Icon(Icons.logout, color: AppColors.white),
        title: const Text('Logout', style: TextStyle(color: AppColors.white)),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}