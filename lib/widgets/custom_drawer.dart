import 'package:flutter/material.dart';
import 'package:gym_management_app/constants/colors.dart';
import 'package:gym_management_app/models/drawer_item_model.dart';

class CustomDrawer extends StatefulWidget {
  final String adminName;
  final String adminEmail;

  const CustomDrawer({
    super.key,
    required this.adminName,
    required this.adminEmail,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int selectedIndex = 0;

  void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.white,
                    child:
                        Icon(Icons.person, size: 40, color: AppColors.primary),
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
                    style: const TextStyle(
                        color: AppColors.grayLight, fontSize: 13),
                  ),
                ],
              ),
            ),

            const Divider(color: AppColors.grayLight),

            Expanded(
              child: ListView.builder(
                itemCount: drawerItems.length,
                itemBuilder: (context, index) {
                  final item = drawerItems[index];
                  final isSelected = selectedIndex == index;

                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                          color:
                              isSelected ? AppColors.primary : AppColors.white,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
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
            ),

            const Divider(color: AppColors.grayLight),

            // Logout
            // ListTile(
            //   leading: const Icon(Icons.logout, color: AppColors.white),
            //   title: const Text('Logout', style: TextStyle(color: AppColors.white)),
            //   onTap: () {
            //     navigateToScreen(context, logoutItem.screen);
            //   },
            // ),
            // const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
