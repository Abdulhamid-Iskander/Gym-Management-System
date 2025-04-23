import 'package:flutter/material.dart';
import 'package:gym_management_app/screens/dashboard_screen.dart';
import 'package:gym_management_app/screens/coaches_screen.dart'; // resolve
// import 'package:gym_management_app/screens/inventory_screen.dart';
// import 'package:gym_management_app/screens/login_screen.dart';
// import 'package:gym_management_app/screens/payment_screen.dart';
import 'package:gym_management_app/screens/plan_screen.dart';
// import 'package:gym_management_app/screens/registration_screen.dart';
// import 'package:gym_management_app/screens/report_screen.dart';
// import 'package:gym_management_app/screens/view_members_screen.dart';


class DrawerItem {
  final IconData icon;
  final String title;
  final Widget screen;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.screen,
  });
}

final List<DrawerItem> drawerItems = [
  DrawerItem(
    icon: Icons.dashboard,
    title: 'Dashboard',
    screen: const DashboardScreen(),
  ),

//   DrawerItem(
//     icon: Icons.app_registration,
//     title: 'Registration',
//     screen: const RegistrationScreen(),
// ),
  
DrawerItem(
  icon: Icons.assignment,
  title: 'Plan',
  screen: const PlanScreen(),
),

//   DrawerItem(
//     icon: Icons.people,
//     title: 'View Members',
//     screen: const ViewMembersScreen(),
//   ),
  DrawerItem(
    icon: Icons.fitness_center,
    title: 'Coaches',
    screen: const CoachesScreen(),
  ),
//   DrawerItem(
//     icon: Icons.analytics,
//     title: 'Report',
//     screen: const ReportScreen(),
//   ),
];

// DrawerItem logoutItem = DrawerItem(
//   icon: Icons.logout,
//   title: 'Logout',
//   screen: const LoginScreen(),
// );
